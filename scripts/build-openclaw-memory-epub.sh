#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BOOK_REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
BOOK_DIR="${BOOK_REPO_ROOT}/openclaw-memory-ko"
BOOK_LICENSE="${BOOK_REPO_ROOT}/LICENSE"
DEFAULT_OUTPUT="${BOOK_REPO_ROOT}/dist/openclaw-memory-chronicle-ko.epub"

usage() {
  cat <<'EOF'
Build the Korean OpenClaw Memory book as an EPUB 3 file.

Usage:
  ./scripts/build-openclaw-memory-epub.sh [output.epub]

Default output:
  dist/openclaw-memory-chronicle-ko.epub

Required commands:
  node, pnpm, pandoc, curl, shasum, unzip, zip, uvx, epubcheck

The build downloads a checksum-pinned Noto Serif KR source font, subsets it to
the book's characters, renders Mermaid diagrams as SVG, fixes cross-chapter
links, and validates the result with epubcheck. Set SOURCE_DATE_EPOCH to choose
the archive timestamp; the default is the book's 2026-07-27 publication date.
EOF
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  usage
  exit 0
fi

if [[ "$#" -gt 1 ]]; then
  usage >&2
  exit 2
fi

OUTPUT="${1:-${DEFAULT_OUTPUT}}"
if [[ "${OUTPUT}" != /* ]]; then
  OUTPUT="${BOOK_REPO_ROOT}/${OUTPUT}"
fi

required_commands=(node pnpm pandoc curl shasum unzip zip uvx epubcheck)
for command_name in "${required_commands[@]}"; do
  if ! command -v "${command_name}" >/dev/null 2>&1; then
    printf 'error: required command not found: %s\n' "${command_name}" >&2
    exit 1
  fi
done

if [[ ! -d "${BOOK_DIR}" ]]; then
  printf 'error: book directory not found: %s\n' "${BOOK_DIR}" >&2
  exit 1
fi
if [[ ! -f "${BOOK_LICENSE}" ]]; then
  printf 'error: book license not found: %s\n' "${BOOK_LICENSE}" >&2
  exit 1
fi

BOOK_FILES=(
  README.md
  00-prologue-and-method.md
  01-current-architecture.md
  02-origins-2025.md
  03-january-february-2026.md
  04-march-2026.md
  05-april-2026.md
  06-may-june-2026.md
  07-july-2026.md
  08-design-turns-and-proposal-review.md
  09-signal-ledger-and-evaluation.md
  10-current-contract-gaps.md
  11-benchmarks-and-roadmap.md
  afterword.md
  12-landmark-index.md
  13-references-reproduction-and-conclusion.md
  14-glossary.md
  appendix-a-source-map.md
)

for book_file in "${BOOK_FILES[@]}"; do
  if [[ ! -f "${BOOK_DIR}/${book_file}" ]]; then
    printf 'error: book chapter not found: %s\n' "${BOOK_DIR}/${book_file}" >&2
    exit 1
  fi
done

BUILD_EPOCH="${SOURCE_DATE_EPOCH:-1785110400}"
if [[ ! "${BUILD_EPOCH}" =~ ^[0-9]+$ ]] || [[ "${BUILD_EPOCH}" -lt 315532800 ]]; then
  printf 'error: SOURCE_DATE_EPOCH must be an integer on or after 1980-01-01.\n' >&2
  exit 1
fi
export SOURCE_DATE_EPOCH="${BUILD_EPOCH}"

OUTPUT_DIR="$(dirname "${OUTPUT}")"
mkdir -p "${OUTPUT_DIR}"

WORK_DIR="$(mktemp -d "${TMPDIR:-/tmp}/openclaw-memory-epub.XXXXXX")"
PUBLISH_DIR="$(mktemp -d "${OUTPUT_DIR}/.openclaw-memory-epub.XXXXXX")"
cleanup() {
  rm -rf "${WORK_DIR}"
  rm -rf "${PUBLISH_DIR}"
}
trap cleanup EXIT

COMBINED_MARKDOWN="${WORK_DIR}/openclaw-memory-ko.md"
DIAGRAM_DIR="${WORK_DIR}/diagrams"
FONT_DIR="${WORK_DIR}/fonts"
RAW_EPUB="${WORK_DIR}/openclaw-memory-ko.raw.epub"
STAGED_EPUB_DIR="${WORK_DIR}/epub"
PACKAGED_EPUB="${PUBLISH_DIR}/$(basename "${OUTPUT}")"
mkdir -p "${DIAGRAM_DIR}" "${FONT_DIR}"

printf 'Preparing chapters and cross-chapter links...\n'
node - "${BOOK_REPO_ROOT}" "${BOOK_DIR}" "${COMBINED_MARKDOWN}" "${DIAGRAM_DIR}" "${BOOK_FILES[@]}" <<'NODE'
const fs = require("node:fs");
const path = require("node:path");

const [repoRoot, bookDir, combinedPath, diagramDir, ...bookFiles] = process.argv.slice(2);
const normalizedRepoRoot = `${path.resolve(repoRoot)}${path.sep}`;
const normalizedBookDir = `${path.resolve(bookDir)}${path.sep}`;
const markdownLinkPattern = /(!?\[[^\]\n]*\]\()(<[^>\n]+>|[^)\s]+)([^)\n]*\))/g;

function chapterId(filename) {
  return `file-${path.basename(filename, ".md").toLowerCase().replace(/[^a-z0-9-]+/g, "-")}`;
}

function isInside(candidate, directoryWithSeparator) {
  return `${path.resolve(candidate)}${path.sep}`.startsWith(directoryWithSeparator);
}

function rewriteLink(match, prefix, rawTarget, suffix, sourcePath) {
  if (prefix.startsWith("![")) {
    return match;
  }

  const wrapped = rawTarget.startsWith("<") && rawTarget.endsWith(">");
  const target = wrapped ? rawTarget.slice(1, -1) : rawTarget;
  if (/^(?:[a-z][a-z0-9+.-]*:|#)/i.test(target)) {
    return match;
  }

  const hashOffset = target.indexOf("#");
  const filePart = hashOffset === -1 ? target : target.slice(0, hashOffset);
  const fragment = hashOffset === -1 ? "" : target.slice(hashOffset + 1);
  if (!filePart.toLowerCase().endsWith(".md")) {
    return match;
  }

  let decodedFilePart;
  try {
    decodedFilePart = decodeURIComponent(filePart);
  } catch {
    decodedFilePart = filePart;
  }
  const resolved = path.resolve(path.dirname(sourcePath), decodedFilePart);
  let rewritten;

  if (isInside(resolved, normalizedBookDir)) {
    if (!fs.existsSync(resolved)) {
      throw new Error(`broken book link in ${sourcePath}: ${target}`);
    }
    rewritten = fragment ? `#${fragment}` : `#${chapterId(resolved)}`;
  } else if (isInside(resolved, normalizedRepoRoot)) {
    const repoRelative = path.relative(repoRoot, resolved).split(path.sep).join("/");
    rewritten = `https://github.com/openclaw/openclaw/blob/main/${repoRelative}`;
    if (fragment) {
      rewritten += `#${fragment}`;
    }
  } else {
    return match;
  }

  return `${prefix}${rewritten}${suffix}`;
}

let diagramNumber = 0;
const combined = [];

for (const bookFile of bookFiles) {
  const sourcePath = path.join(bookDir, bookFile);
  let markdown = fs.readFileSync(sourcePath, "utf8");
  const lines = markdown.split("\n");
  if (!lines[0].startsWith("# ")) {
    throw new Error(`expected the first line to be a level-one heading: ${sourcePath}`);
  }
  if (!/\{#[^}]+\}\s*$/.test(lines[0])) {
    lines[0] = `${lines[0]} {#${chapterId(bookFile)}}`;
  }
  markdown = lines.join("\n");

  markdown = markdown.replace(markdownLinkPattern, (match, prefix, target, suffix) =>
    rewriteLink(match, prefix, target, suffix, sourcePath),
  );

  markdown = markdown.replace(/```mermaid[^\n]*\n([\s\S]*?)```/g, (_match, source, offset) => {
    diagramNumber += 1;
    const stem = `${String(diagramNumber).padStart(2, "0")}-${path.basename(bookFile, ".md")}`;
    const sourceFile = path.join(diagramDir, `${stem}.mmd`);
    const outputFile = path.join(diagramDir, `${stem}.svg`);
    fs.writeFileSync(sourceFile, `${source.trim()}\n`);

    const precedingHeadings = markdown
      .slice(0, offset)
      .match(/^#{1,6}\s+.+$/gm);
    const heading = precedingHeadings?.at(-1) ?? lines[0];
    const alt = heading
      .replace(/^#{1,6}\s+/, "")
      .replace(/\s+\{#[^}]+\}\s*$/, "")
      .replace(/[`*_]/g, "")
      .trim();
    return `![${alt} 도식](${outputFile})`;
  });

  combined.push(markdown.trimEnd());
}

const license = fs.readFileSync(path.join(repoRoot, "LICENSE"), "utf8").trimEnd();
combined.push(
  [
    "# 라이선스 {#book-license}",
    "",
    "이 책의 본문과 저장소 소스는 다음 MIT License에 따라 배포된다.",
    "",
    "```text",
    license,
    "```",
  ].join("\n"),
);

fs.writeFileSync(combinedPath, `${combined.join("\n\n")}\n`);
fs.writeFileSync(path.join(diagramDir, "count"), `${diagramNumber}\n`);
NODE

DIAGRAM_COUNT="$(tr -d '[:space:]' < "${DIAGRAM_DIR}/count")"

FONT_REVISION="389b770410cc0b7c21c85673bfa2077420fe7f65"
FONT_URL="https://raw.githubusercontent.com/google/fonts/${FONT_REVISION}/ofl/notoserifkr/NotoSerifKR%5Bwght%5D.ttf"
FONT_LICENSE_URL="https://raw.githubusercontent.com/google/fonts/${FONT_REVISION}/ofl/notoserifkr/OFL.txt"
FONT_SHA256="11f8d5de6f1b79195efba3828aaa2ec95c1178f5ae976fb23c8d53250a9938f3"
FONT_LICENSE_SHA256="5e0da210fb04058a8c0087985d2d456b931c2579811a49655721d3cf0c36b6d6"
FONT_SOURCE="${FONT_DIR}/NotoSerifKR-variable.ttf"
FONT_SUBSET="${FONT_DIR}/NotoSerifKR-subset.woff2"
FONT_LICENSE="${FONT_DIR}/OFL.txt"
FONT_TEXT="${WORK_DIR}/font-text.txt"

printf 'Downloading and subsetting Noto Serif KR...\n'
curl --fail --location --silent --show-error "${FONT_URL}" --output "${FONT_SOURCE}"
curl --fail --location --silent --show-error "${FONT_LICENSE_URL}" --output "${FONT_LICENSE}"

verify_sha256() {
  local expected="$1"
  local file="$2"
  local actual
  actual="$(shasum -a 256 "${file}" | awk '{print $1}')"
  if [[ "${actual}" != "${expected}" ]]; then
    printf 'error: checksum mismatch for %s\n' "${file}" >&2
    printf 'expected: %s\nactual:   %s\n' "${expected}" "${actual}" >&2
    exit 1
  fi
}

verify_sha256 "${FONT_SHA256}" "${FONT_SOURCE}"
verify_sha256 "${FONT_LICENSE_SHA256}" "${FONT_LICENSE}"

(
  cat "${COMBINED_MARKDOWN}"
  if [[ "${DIAGRAM_COUNT}" -gt 0 ]]; then
    for diagram_source in "${DIAGRAM_DIR}"/*.mmd; do
      cat "${diagram_source}"
    done
  fi
) > "${FONT_TEXT}"

uvx --quiet --from 'fonttools[woff]==4.60.2' fonttools subset \
  "${FONT_SOURCE}" \
  --text-file="${FONT_TEXT}" \
  --layout-features='*' \
  --name-IDs='*' \
  --name-legacy \
  --name-languages='*' \
  --flavor=woff2 \
  --output-file="${FONT_SUBSET}"

if [[ "${DIAGRAM_COUNT}" -gt 0 ]]; then
  MERMAID_CONFIG="${WORK_DIR}/mermaid-config.json"
  cat > "${MERMAID_CONFIG}" <<'JSON'
{
  "deterministicIds": true,
  "deterministicIDSeed": "openclaw-memory-ko-2026-07-27",
  "flowchart": {
    "htmlLabels": false
  },
  "htmlLabels": false,
  "themeVariables": {
    "fontFamily": "OpenClaw Mermaid KR, Noto Serif CJK KR, AppleMyungjo, serif"
  }
}
JSON

  MERMAID_RENDERER="${WORK_DIR}/render-mermaid.mjs"
  cat > "${MERMAID_RENDERER}" <<'NODE'
import fs from "node:fs";
import path from "node:path";
import { createRequire } from "node:module";
import { pathToFileURL } from "node:url";

const [mmdcBin, diagramDir, chromePath, fontPath, configPath] = process.argv.slice(2);
const shim = fs.readFileSync(mmdcBin, "utf8");
const targetMatch = shim.match(/^# cmd-shim-target=(.+)$/m);
if (!targetMatch) {
  throw new Error(`could not resolve the pinned Mermaid CLI from ${mmdcBin}`);
}

const cliTarget = targetMatch[1].trim();
const packageRoot = path.dirname(path.dirname(cliTarget));
const requireFromCli = createRequire(path.join(packageRoot, "package.json"));
const puppeteerPath = requireFromCli.resolve("puppeteer");
const [{ renderMermaid }, { default: puppeteer }] = await Promise.all([
  import(pathToFileURL(path.join(packageRoot, "src", "index.js")).href),
  import(pathToFileURL(puppeteerPath).href),
]);

const fontData = fs.readFileSync(fontPath).toString("base64");
const renderFontURL = `data:font/woff2;base64,${fontData}`;
const fontFaceCSS = `@font-face {
  font-family: "OpenClaw Mermaid KR";
  font-style: normal;
  font-weight: 200 900;
  src: url("${renderFontURL}") format("woff2");
}`;
const renderFontCSS = `${fontFaceCSS}
html, body, svg, text {
  font-family: "OpenClaw Mermaid KR", serif !important;
}`;
const embeddedFontCSS = `${fontFaceCSS}
text {
  font-family: "OpenClaw Mermaid KR", serif !important;
}`;
const mermaidConfig = JSON.parse(fs.readFileSync(configPath, "utf8"));
const browser = await puppeteer.launch({ executablePath: chromePath, headless: "shell" });
const originalNewPage = browser.newPage.bind(browser);

browser.newPage = async () => {
  const page = await originalNewPage();
  const originalEval = page.$eval.bind(page);
  page.$eval = async (selector, ...args) => {
    if (selector === "#container") {
      await page.addStyleTag({ content: renderFontCSS });
      await page.evaluate(async () => {
        const loaded = await document.fonts.load('16px "OpenClaw Mermaid KR"');
        if (loaded.length === 0) {
          throw new Error("Noto Serif KR did not load before Mermaid layout");
        }
        await document.fonts.ready;
      });
    }
    return originalEval(selector, ...args);
  };
  return page;
};

try {
  const diagramFiles = fs
    .readdirSync(diagramDir)
    .filter((filename) => filename.endsWith(".mmd"))
    .sort();
  for (const filename of diagramFiles) {
    const sourcePath = path.join(diagramDir, filename);
    const stem = path.basename(filename, ".mmd");
    const outputPath = path.join(diagramDir, `${stem}.svg`);
    const definition = fs.readFileSync(sourcePath, "utf8");
    const { data } = await renderMermaid(browser, definition, "svg", {
      backgroundColor: "transparent",
      mermaidConfig,
      myCSS: embeddedFontCSS,
      svgId: `diagram-${stem}`,
    });
    const serialized = Buffer.from(data)
      .toString("utf8")
      .replaceAll(renderFontURL, "../fonts/NotoSerifKR-subset.woff2");
    if (serialized.includes("data:font") || !serialized.includes("../fonts/NotoSerifKR-subset.woff2")) {
      throw new Error(`failed to rewrite the packaged font reference in ${outputPath}`);
    }
    fs.writeFileSync(outputPath, serialized);
  }
} finally {
  await browser.close();
}
NODE

  CHROME_PATH="${PUPPETEER_EXECUTABLE_PATH:-}"
  if [[ -z "${CHROME_PATH}" ]]; then
    chrome_candidates=(
      "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
      "/Applications/Chromium.app/Contents/MacOS/Chromium"
    )
    for chrome_candidate in "${chrome_candidates[@]}"; do
      if [[ -x "${chrome_candidate}" ]]; then
        CHROME_PATH="${chrome_candidate}"
        break
      fi
    done
  fi
  if [[ -z "${CHROME_PATH}" ]]; then
    for chrome_command in google-chrome-stable google-chrome chromium chromium-browser; do
      if command -v "${chrome_command}" >/dev/null 2>&1; then
        CHROME_PATH="$(command -v "${chrome_command}")"
        break
      fi
    done
  fi
  if [[ -z "${CHROME_PATH}" ]]; then
    printf '%s\n' 'error: Chrome or Chromium is required to render Mermaid diagrams.' >&2
    printf '%s\n' 'Set PUPPETEER_EXECUTABLE_PATH to the browser executable.' >&2
    exit 1
  fi

  printf 'Rendering %s Mermaid diagrams...\n' "${DIAGRAM_COUNT}"
  MERMAID_RENDERER="${MERMAID_RENDERER}" \
    MERMAID_DIAGRAM_DIR="${DIAGRAM_DIR}" \
    MERMAID_CHROME_PATH="${CHROME_PATH}" \
    MERMAID_FONT_PATH="${FONT_SUBSET}" \
    MERMAID_CONFIG_PATH="${MERMAID_CONFIG}" \
    pnpm --silent dlx --package @mermaid-js/mermaid-cli@11.12.0 -- sh -c \
    'node "$MERMAID_RENDERER" "$(command -v mmdc)" "$MERMAID_DIAGRAM_DIR" "$MERMAID_CHROME_PATH" "$MERMAID_FONT_PATH" "$MERMAID_CONFIG_PATH"'
fi

CSS_FILE="${WORK_DIR}/epub.css"
cat > "${CSS_FILE}" <<'CSS'
@font-face {
  font-family: "OpenClaw Serif KR";
  font-style: normal;
  font-weight: 200 900;
  src: url("../fonts/NotoSerifKR-subset.woff2") format("woff2");
}

html,
body {
  font-family: "OpenClaw Serif KR", "Noto Serif CJK KR", "Apple SD Gothic Neo", "Malgun Gothic", serif;
  line-height: 1.62;
  overflow-wrap: anywhere;
  word-wrap: break-word;
}

p,
li,
dd,
td,
th,
blockquote {
  line-height: 1.62;
}

h1,
h2,
h3,
h4,
h5,
h6 {
  font-family: "OpenClaw Serif KR", "Noto Serif CJK KR", "Apple SD Gothic Neo", "Malgun Gothic", serif;
  font-weight: 700;
  line-height: 1.35;
  word-break: keep-all;
}

code,
kbd,
samp,
pre {
  font-family: Menlo, Monaco, "Lucida Console", Consolas, "OpenClaw Serif KR", monospace;
}

code,
a {
  overflow-wrap: anywhere;
}

pre {
  white-space: pre-wrap;
}

table {
  border-collapse: collapse;
  font-size: 0.85em;
  width: 100%;
}

th,
td {
  border: 1px solid #999;
  padding: 0.35em;
  vertical-align: top;
}

img {
  height: auto;
  max-width: 100%;
}

body > nav#toc ol,
body > nav#toc ul {
  line-height: 1.55;
}
CSS

printf 'Building EPUB...\n'
pandoc "${COMBINED_MARKDOWN}" \
  --from=gfm+attributes \
  --to=epub3 \
  --output="${RAW_EPUB}" \
  --toc \
  --toc-depth=3 \
  --split-level=1 \
  --css="${CSS_FILE}" \
  --epub-embed-font="${FONT_SUBSET}" \
  --resource-path="${WORK_DIR}:${BOOK_DIR}:${BOOK_REPO_ROOT}" \
  --metadata='title=OpenClaw는 어떻게 기억하는가: 메모리 구조의 현재와 진화사' \
  --metadata='lang=ko-KR' \
  --metadata='toc-title=목차' \
  --metadata='date=2026-07-27' \
  --metadata='identifier=urn:openclaw:book:openclaw-memory-chronicle-ko:2026-07-27' \
  --metadata='page-progression-direction=ltr' \
  --metadata='rights=Book text: MIT License. Embedded Noto Serif KR: SIL Open Font License 1.1.'

mkdir -p "${STAGED_EPUB_DIR}"
unzip -q "${RAW_EPUB}" -d "${STAGED_EPUB_DIR}"
mkdir -p "${STAGED_EPUB_DIR}/EPUB/fonts"
cp "${FONT_LICENSE}" "${STAGED_EPUB_DIR}/EPUB/fonts/OFL.txt"

node - "${STAGED_EPUB_DIR}/EPUB/content.opf" <<'NODE'
const fs = require("node:fs");

const opfPath = process.argv[2];
let opf = fs.readFileSync(opfPath, "utf8");
if (!opf.includes('href="fonts/OFL.txt"')) {
  opf = opf.replace(
    /\s*<\/manifest>/,
    '\n    <item id="NotoSerifKR_OFL" href="fonts/OFL.txt" media-type="text/plain" />\n  </manifest>',
  );
}
fs.writeFileSync(opfPath, opf);
NODE

node - "${STAGED_EPUB_DIR}" "${BUILD_EPOCH}" <<'NODE'
const fs = require("node:fs");
const path = require("node:path");

const root = process.argv[2];
const epoch = Number(process.argv[3]);
const timestamp = new Date(epoch * 1000);

function normalizeTimestamps(directory) {
  for (const entry of fs.readdirSync(directory, { withFileTypes: true }).sort((a, b) =>
    a.name.localeCompare(b.name, "en"),
  )) {
    const entryPath = path.join(directory, entry.name);
    if (entry.isDirectory()) {
      normalizeTimestamps(entryPath);
      fs.chmodSync(entryPath, 0o755);
    } else {
      fs.chmodSync(entryPath, 0o644);
    }
    fs.utimesSync(entryPath, timestamp, timestamp);
  }
}

normalizeTimestamps(root);
fs.chmodSync(root, 0o755);
fs.utimesSync(root, timestamp, timestamp);
NODE

(
  cd "${STAGED_EPUB_DIR}"
  TZ=UTC zip -X0 "${PACKAGED_EPUB}" mimetype >/dev/null
  find META-INF EPUB -type f -print | LC_ALL=C sort | TZ=UTC zip -X9D "${PACKAGED_EPUB}" -@ >/dev/null
)

printf 'Validating EPUB...\n'
epubcheck "${PACKAGED_EPUB}"

mv "${PACKAGED_EPUB}" "${OUTPUT}"
printf 'Built %s\n' "${OUTPUT#"${BOOK_REPO_ROOT}/"}"
