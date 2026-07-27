# OpenClaw는 어떻게 기억하는가

**메모리 구조의 현재와 진화사**

OpenClaw가 대화를 이어 가고, 사실을 오래 보존하고, 과거 기록을 다시 찾는 구조가 어떻게 만들어졌는지를 추적한 한국어 기술서다. 현재 아키텍처뿐 아니라 2025년의 파일 관례가 2026년의 검색·권한·플러그인·SQLite 계약으로 발전한 과정과 그 근거를 함께 다룬다.

## 읽기

- [책 목차와 본문](openclaw-memory-ko/README.md)
- [EPUB 다운로드](dist/openclaw-memory-chronicle-ko.epub)
- [이정표 커밋과 출시 인덱스](openclaw-memory-ko/12-landmark-index.md)
- [출처와 재현 안내](openclaw-memory-ko/13-references-reproduction-and-conclusion.md)
- [근거 감사 지도](openclaw-memory-ko/appendix-a-source-map.md)

본문은 한국어로 쓰되 코드 식별자와 1차 자료 링크는 원문을 유지한다. 아키텍처 기준점은 OpenClaw `main`의 `a115af277410a91fb039d2ed699eafad706f5c73`(2026-07-18)이며, 출시 상태는 2026-07-26에 마지막으로 확인했다.

## EPUB 빌드

독립 체크아웃에서는 이 저장소의 루트에서 실행한다.

```bash
./scripts/build-openclaw-memory-epub.sh
```

OpenClaw 소스 트리의 `books/` 경로에서 작업한다면 상위 OpenClaw 루트에 있는 같은 이름의 스크립트를 실행해도 된다. 그 진입점은 이 저장소가 소유한 생성기로 위임한다.

```bash
../scripts/build-openclaw-memory-epub.sh
```

두 경우 모두 기본 산출물은 이 저장소의 `dist/openclaw-memory-chronicle-ko.epub`이다. OpenClaw 루트에서 보면 `books/dist/openclaw-memory-chronicle-ko.epub`이다. 빌드는 Pandoc으로 EPUB 3을 만들고, Mermaid 도식을 SVG로 렌더링하며, 한국어 글꼴을 필요한 글리프만 포함하도록 줄인 뒤 EPUBCheck로 결과를 검증한다.

필요한 명령과 선택적 출력 경로는 다음 명령으로 확인할 수 있다.

```bash
./scripts/build-openclaw-memory-epub.sh --help
./scripts/build-openclaw-memory-epub.sh dist/custom-name.epub
```

## 범위

이 책은 역사와 구조를 설명하는 고정 판본이다. 개별 기능의 최신 설정과 운영 절차는 [OpenClaw 공식 문서](https://docs.openclaw.ai/)를 기준으로 확인해야 한다. 책의 사실 오류나 깨진 링크는 재현 근거와 함께 이 저장소의 이슈로 제보할 수 있다.

## 라이선스

책과 저장소 소스는 [MIT License](LICENSE)로 배포한다. EPUB에 포함된 Noto Serif KR 글꼴은 SIL Open Font License 1.1을 따르며, 라이선스 전문은 EPUB 안에 함께 들어 있다.
