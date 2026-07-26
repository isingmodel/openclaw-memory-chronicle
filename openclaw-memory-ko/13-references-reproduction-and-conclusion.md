# 13장. 출처와 재현 안내

[← 이전: 이정표 색인](12-landmark-index.md) · [목차](README.md) · [다음: 용어집 →](14-glossary.md)

정본인 이 책의 주장을 독립적으로 확인하고 싶은 독자를 위한 장이다. OpenClaw 저장소, 공식 제품 문서, 고정된 외부 1차 자료, 역사를 재현하는 명령과 조사 한계를 한곳에 모았다. 공식 문서 링크는 배포 사이트의 절대 URL로 적었다.

본문을 이해하는 데 이 목록을 먼저 읽을 필요는 없다. 다만 어떤 문장이 현재 계약인지, 출시된 동작인지, 과거 제안인지 의심스러울 때는 이 장과 [이정표 색인](12-landmark-index.md)으로 돌아오면 된다.

## 조사 기준점

- 저장소: [`openclaw/openclaw`](https://github.com/openclaw/openclaw)
- 조사 기준점: OpenClaw `main`의 [`a115af277410`](https://github.com/openclaw/openclaw/tree/a115af277410a91fb039d2ed699eafad706f5c73), 2026-07-18
- 근거 원칙: 코드·테스트·Git 이력으로 동작과 시점을 먼저 확정하고, 연결된 PR·이슈·릴리스·공식 문서와 외부 1차 자료로 동기와 계약을 교차 확인한다.

## 현재 공식 문서

- [메모리 개요](https://docs.openclaw.ai/concepts/memory)
- [내장 메모리 엔진](https://docs.openclaw.ai/concepts/memory-builtin)
- [메모리 검색](https://docs.openclaw.ai/concepts/memory-search)
- [QMD(Query Markup Documents) 메모리 엔진](https://docs.openclaw.ai/concepts/memory-qmd)
- [Active Memory](https://docs.openclaw.ai/concepts/active-memory)
- [Dreaming](https://docs.openclaw.ai/concepts/dreaming)
- [메모리 설정](https://docs.openclaw.ai/reference/memory-config)
- [`openclaw memory` CLI](https://docs.openclaw.ai/cli/memory)
- [세션 검색](https://docs.openclaw.ai/concepts/session-search)
- [Memory Wiki](https://docs.openclaw.ai/plugins/memory-wiki)
- [LanceDB 메모리 플러그인](https://docs.openclaw.ai/plugins/memory-lancedb)
- [Honcho 메모리](https://docs.openclaw.ai/concepts/memory-honcho)
- [2026.6.11 릴리스 노트](https://docs.openclaw.ai/releases/2026.6.11)와 [2026.7.1 릴리스 노트](https://docs.openclaw.ai/releases/2026.7.1)

## 외부 1차 자료

비교 대상은 이름이나 마케팅 설명이 아니라, 논문과 고정된 소스 리비전·데이터셋 카드·라이선스를 우선했다.

- [Hindsight 논문](https://arxiv.org/abs/2512.12818)과 [조사한 오픈 소스 리비전](https://github.com/vectorize-io/hindsight/tree/327aa05e80c89e2f02e9122123469f8b0bd91d0c)
- Letta의 [메모리 블록](https://docs.letta.com/guides/core-concepts/memory/memory-blocks), [컨텍스트 계층](https://docs.letta.com/guides/core-concepts/memory/context-hierarchy), [파일시스템 메모리 벤치마크 논의](https://www.letta.com/blog/benchmarking-ai-agent-memory/)
- [SuCo 논문](https://arxiv.org/abs/2411.14754)
- QMD의 [이름·역할·세 검색 명령](https://github.com/tobi/qmd/blob/e428df76bc0274d9e93eb7ca3e95673315c42e90/README.md#L1-L49)과 [당시 검색 파이프라인](https://github.com/tobi/qmd/blob/e428df76bc0274d9e93eb7ca3e95673315c42e90/README.md#L404-L491)
- [sqlite-vec 소스와 계약](https://github.com/asg017/sqlite-vec/blob/04d28bd21773981e2d266bbf6aa4efbd011eb4f6/README.md#L5-L86)
- [LanceDB 소스와 기능 개요](https://github.com/lancedb/lancedb/blob/5d0a1ef66cc96972f0e61281f7fdee5e16afde9c/README.md#L42-L67)
- [조사한 리비전의 Codex 메모리 파이프라인](https://github.com/openai/codex/blob/56395bddaf26eb2829387ca6a417bf9128e5b239/codex-rs/memories/README.md#L29-L120)
- [LongMemEval 논문](https://arxiv.org/abs/2410.10813), [고정된 데이터셋 카드·라이선스](https://huggingface.co/datasets/xiaowu0162/longmemeval-cleaned/blob/98d7416c24c778c2fee6e6f3006e7a073259d48f/README.md), [코드 라이선스](https://github.com/xiaowu0162/LongMemEval/blob/9e0b455f4ef0e2ab8f2e582289761153549043fc/LICENSE)
- [MEME 논문](https://arxiv.org/abs/2605.12477), [고정된 데이터셋 카드·라이선스·저작자 표시](https://huggingface.co/datasets/meme-benchmark/MEME/blob/03932fd33a08debf182ad01a47504024201d86f2/README.md), [코드 라이선스](https://github.com/SeokwonJung-Jay/MEME-public/blob/0271ad85389a963cbc4892a36391f868ba4d18d1/LICENSE)
- [MemoryAgentBench 논문](https://arxiv.org/abs/2507.05257), [고정된 데이터셋 카드](https://huggingface.co/datasets/ai-hyz/MemoryAgentBench/blob/7ea066982b140a19337e17e60d45d4076e042faf/README.md), [코드 라이선스](https://github.com/HUST-AI-HYZ/MemoryAgentBench/blob/455306dcabc3842526eb83cd4e225e5d486c5c5d/LICENSE)
- [BEAM 논문](https://arxiv.org/abs/2510.27246), [고정된 데이터셋 카드·라이선스](https://huggingface.co/datasets/Mohammadta/BEAM/blob/3205395e897e7318c7b094ef4e6047b9b82dbb03/README.md), [하네스 라이선스](https://github.com/mem0ai/memory-benchmarks/blob/4b61c5d31b9c668a12b4f5e78064248a02c82d2b/LICENSE)
- [LongMemEval-V2 논문](https://arxiv.org/abs/2605.12493), [고정된 데이터셋 라이선스](https://huggingface.co/datasets/xiaowu0162/longmemeval-v2/blob/f152293e235517d504809563c833d7190b8c713b/LICENSE), [코드 라이선스](https://github.com/xiaowu0162/LongMemEval-V2/blob/be15ea6e995462f3391c1a610892df3f67dfa7bd/LICENSE)
- [LoCoMo 논문](https://aclanthology.org/2024.acl-long.747/)과 [고정된 데이터셋 라이선스](https://github.com/snap-research/locomo/blob/3eb6f2c585f5e1699204e3c3bdf7adc5c28cb376/LICENSE.txt)

## 평가 자산의 고정 리비전과 데이터 무결성 값

다음 표는 acquisition manifest로 취급해야 한다. 이 책의 조사에서 Hugging Face 값은 인용한 revision에 게시된 LFS SHA-256 object ID를 repository metadata와 대조했다. 큰 dataset file을 모두 내려받아 독립적으로 다시 hash하지는 않았다. LoCoMo 값은 고정된 raw file에서 계산했고, LongMemEval-V2 값은 dataset이 공개한 checksum manifest를 인용했다.

따라서 다운로드한 artifact를 benchmark run에 받아들이기 전에는 반드시 다시 hash해야 한다. 아래 값은 그 검증을 생략해도 된다는 뜻이 아니다.

| Dataset             | 고정 file/checksum                                                                                                                                                                                                                                                                                                                                                                      |
| ------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| LongMemEval cleaned | `longmemeval_s_cleaned.json d6f21ea9d60a0d56f34a05b609c79c88a451d2ae03597821ea3d5a9678c3a442`; `longmemeval_m_cleaned.json 9d79e5524794a2e6900a3aa9cb7d9152c5a3e8319c9a87c25494ba1eacee495f`; `longmemeval_oracle.json 821a2034d219ab45846873dd14c14f12cfe7776e73527a483f9dac095d38620c`                                                                                                |
| MEME                | `meme_filler32k.json a88d28374a002b3e5b1683fb7201d06a1ce739d2ebf94c971c37bb65cf6ebdd3`; `meme_filler128k.json eb861f866dde067e6c7ea6db9bdf17b83a56cdc578dcca57d9d8809dc22747fe`; `meme_nofiller.json 1687d028cc1638986df9f58f0c3f072f614cf13d72a791541b4439fddf701636`                                                                                                                  |
| MemoryAgentBench    | `Accurate_Retrieval 56c3cd80fb6731a3e53cd1a6be3148f54df60ff2d290ee50e28f8acebf9655c1`; `Conflict_Resolution 24d5c3f09ce0ce15625cb9f8a98f44f0d864ca6c94d7b4ad04eb697ca3a5ff45`; `Long_Range_Understanding 5ab175461954db67770d4a4cb69e569b513ebb96aceb9ee79b57f67488bcd539`; `Test_Time_Learning 5338753be48f925d03318eed66117286e3489025fabe050a547bd086cd7d79c0`                       |
| BEAM                | `100K c0519be25907005ba873c927c50877471d550873039d96c041554d0075a78ace`; `500K af05921c979355038e1761b7cde3d2dd713200dd3071b278de0200f6c7f30122`; `1M 41b5acbbb55a586b1305514ef9d9fb03365d9b3331b598a1c2dd7603d93ef533`; `10M shard 0 31d96fd47ec56221d202e68792f26c00e49467dd4b36ee105c36ebd19ef78ad5`; `10M shard 1 a4f13fe25af51d57405ae41008689c31d1421377f3efde56a024b441deb2ee65` |
| LongMemEval-V2      | 공개된 [`checksums.sha256`](https://huggingface.co/datasets/xiaowu0162/longmemeval-v2/blob/f152293e235517d504809563c833d7190b8c713b/checksums.sha256). 주요 파일: `questions.jsonl 0a3ae5ebea938c24d7800e1e0b0828e08ae1646f939a53853b2b8cdc08e292b7`, `trajectories.jsonl 363cec9a8e87aa8d9101ce4e600aadbf7031d674056ebe4f969e8424abc5f3c6`                                             |
| LoCoMo              | `locomo10.json 79fa87e90f04081343b8c8debecb80a9a6842b76a7aa537dc9fdf651ea698ff4`                                                                                                                                                                                                                                                                                                        |

이 표가 고정하는 것은 평가 결과가 아니라 입력의 정체다. 같은 이름의 데이터셋이라도 리비전과 체크섬이 다르면 같은 실험으로 비교할 수 없으며, 실제로 받은 파일의 해시 검증은 입수 단계에서 다시 수행해야 한다.

## 역사를 재현하는 법

다음은 조사에 사용한 대표 명령이다. `<sha>`, `<repo-relative-path>`, `<number>`는 검증하려는 커밋·저장소 상대 경로·PR 또는 이슈 번호로 바꾼다.

```bash
git log a115af277410a91fb039d2ed699eafad706f5c73 --reverse --follow -- docs/templates/AGENTS.md
git show 590f3d0e8f285d02e594cd718bfe9350ea5ee267:docs/templates/AGENTS.md
git show cfd3efb6e767bcab8bbc2617913be2259e953bbb:docs/templates/AGENTS.md
git show 760a83d256d63b55905681cadac60bebca684b73:docs/research/memory.md

git log a115af277410a91fb039d2ed699eafad706f5c73 --reverse -- src/memory/index.ts
git log a115af277410a91fb039d2ed699eafad706f5c73 --reverse -- extensions/memory-core packages/memory-host-sdk
git log a115af277410a91fb039d2ed699eafad706f5c73 --reverse --follow -- extensions/active-memory/index.ts
git log a115af277410a91fb039d2ed699eafad706f5c73 --reverse --follow -- src/auto-reply/reply/startup-context.ts

git show --stat --format=fuller <sha>
git diff <sha>^ <sha> -- <repo-relative-path>
git merge-base --is-ancestor <sha> a115af277410a91fb039d2ed699eafad706f5c73
git show -s --format=%ct a115af277410a91fb039d2ed699eafad706f5c73
git tag --contains <sha> -l 'v*' --sort=creatordate
git for-each-ref 'refs/tags/v*' --sort=creatordate --format='%(refname:short) %(creatordate:unix)'

gh pr view <number> --repo openclaw/openclaw
gh issue view <number> --repo openclaw/openclaw
```

이 명령 묶음은 한 파일의 계보, 특정 시점의 내용, 기능 소유권이 이동한 경로, 커밋의 컷오프 포함 여부, 커밋 포함 관계로 찾은 가장 이른 태그, 외부에 기록된 동기를 각각 교차 확인하게 해 준다. 태그가 존재한다는 사실만으로 기능이 그 태그에서 실제 설정·마이그레이션까지 온전히 동작했다고 추론해서는 안 된다.

## 변화의 동기를 재현하는 법

코드 차이는 대개 **무엇을 어떻게 바꿨는지**는 잘 보여 주지만, 그 자체만으로 **왜 바꿨는지**를 모두 말해 주지는 않는다. 이 책은 다음 순서로 동기를 판정했다.

1. 먼저 커밋의 전체 변경과 테스트를 읽어 실제 동작 변화를 확정한다.
2. 커밋 메시지와 연결된 PR 본문·리뷰·이슈가 문제와 목표를 직접 밝히는지 확인한다. 요청이나 장애가 그 자체로 명시적이라는 사실과, 그것이 특정 후속 변경의 직접 동기라는 사실은 별개다. 후자를 말하려면 변경 PR·커밋이 그 자료를 연결하거나 같은 1차 자료가 해당 변경이 요청에 답한다고 직접 밝혀야 한다.
3. 사용자의 장애 보고, 성능 수치, 폴백·마이그레이션 실패가 해당 변경에 직접 연결되어 있는지 확인한다. 연결되어 있으면 사건이 직접 동기이고, 시기와 증상만 비슷하면 `맥락적` 신호다.
4. 외부 설명이 없으면 변경된 소유권·호출 순서·폴백·삭제된 경로가 허용하는 범위에서만 `코드에서 추론`한다. 저자의 심리나 제품 우선순위를 만들어 내지 않는다.
5. 과거 제안과 나중 기능의 모양이 닮았더라도 후속 PR이 그 제안을 인용하지 않으면 `기능의 대응 관계`로만 적고 직접 인과라고 부르지 않는다.

특히 폴백은 두 질문으로 나눴다. “조사 기준점 코드가 실패할 때 어디로 돌아가는가”는 코드와 테스트로 확인할 수 있는 계약이다. “어떤 실제 폴백 사건 때문에 이 코드가 생겼는가”는 연결된 이슈·PR·운영 기록이 있어야 말할 수 있는 역사적 동기다. [12장의 동기 열](12-landmark-index.md)은 이 원칙을 각 이정표에 적용한 요약이고, 2장부터 7장의 `변화의 동기` 문단은 그 근거와 구현 선택을 문맥 안에서 풀어 쓴다.

## 조사 한계

- 컷오프 SHA `a115af277410a91fb039d2ed699eafad706f5c73`의 조상인 커밋만 현재 역사로 취급했다. 중복 커밋이나 폐기된 브랜치 커밋은, 출시되지 않은 제안으로 명시한 경우를 제외하고 배제했다.
- PR·이슈에 적힌 동기는 명시적 근거를 의역하는 데만 사용했다. 코드 모양에서 읽어 낸 의도는 추론이라고 표시했다.
- 구버전을 대상으로 열린 보고서는 현재 소스에서 재현하지 않고 현재 결함으로 승격하지 않았다.
- 최초 포함 태그 대응은 커밋 포함 관계와 태그 생성 순서를 사용하고 컷오프 커밋 뒤에 생성된 태그를 제외한다. 이는 릴리스 경계를 찾는 보조 수단이지 설치 현황 조사가 아니다.
- 이 저장소는 GitHub Discussions를 비활성화했으므로 검색할 토론 코퍼스가 없었다.
- 이 역사를 한 번에 다룬 공식 회고 블로그는 없었다. 따라서 1차 커밋, PR·이슈, 문서·릴리스, 업스트림 자료를 우선했다.
- 이 책은 문서 기반의 고고학 조사다. 조사 과정에서 런타임 동작을 바꾸거나 벤치마크 스위트를 실행하지 않았다.

## 이 자료편의 역할

이 장은 서사를 다시 끝내는 두 번째 결론이 아니다. 책의 역사와 설계 논증은 [맺음말](afterword.md)에서 닫힌다. 이곳에는 그 결론을 독자가 독립적으로 확인하는 데 필요한 출처, 고정 리비전, 데이터 무결성 값, 재현 명령과 조사 한계만 남긴다. 의심스러운 주장 하나를 만났다면 12장에서 해당 이정표를 찾고, 이 장의 명령과 출처를 사용해 코드·태그·동기 근거를 다시 확인하면 된다.

---

[← 이전: 이정표 색인](12-landmark-index.md) · [목차](README.md) · [다음: 용어집 →](14-glossary.md)
