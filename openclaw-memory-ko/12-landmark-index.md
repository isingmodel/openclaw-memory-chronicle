# 12장. 이정표 커밋과 릴리스 색인

[← 이전: 맺음말](afterword.md) · [목차](README.md) · [다음: 출처와 재현 안내 →](13-references-reproduction-and-conclusion.md)

앞선 장들은 기억 시스템의 변화를 문제와 선택의 연쇄로 풀어냈다. 이제 그 이야기를 다시 검증하고 싶은 독자를 위해, 41개 이정표의 빠른 표와 54개 고유 커밋의 상세 근거를 한곳에 모은다. 이 색인은 처음부터 끝까지 읽는 본문이라기보다, 특정 기능이 언제 등장했고 어느 태그 포함 경계를 통과했는지 되짚는 지도다.

표를 읽을 때는 “커밋됨”, “`main`에 병합됨”, “릴리스 태그에 포함됨”을 구분해야 한다. 날짜는 각 행에 첫 번째로 나열된 커밋의 UTC 기준 커미터 날짜이며, 마지막 열은 커밋 포함 관계와 태그 생성 순서로 찾은 **최초 포함 태그**다. 이는 설치 현황 조사나 기능의 실사용 가능 시점을 완전히 대신하지 않는다. 아키텍처의 “현재”는 `a115af277410a91fb039d2ed699eafad706f5c73`에 고정한다. 다만 출시 상태가 낡지 않도록 이후 생성된 태그도 2026-07-26에 별도로 확인했으며, 이 후속 확인은 고정본의 런타임 계약을 바꾸지 않는다.

## 빠른 연대기

이 표는 날짜·이정표·최초 포함 태그만 보여 준다. 커밋과 동기 근거는 아래의 같은 이름 항목에서 읽는다.

| 날짜       | 이정표                                                                 | 최초 포함 태그                                                                             |
| ---------- | ---------------------------------------------------------------------- | ------------------------------------------------------------------------------------------ |
| 2025-11-24 | 영속 세션 ID를 통한 연속성                                             | [`v0.1.0`](https://github.com/openclaw/openclaw/releases/tag/v0.1.0)                       |
| 2025-11-27 | 사용자별 소문자 `memory.md` 시작 로딩                                  | [`v1.2.0`](https://github.com/openclaw/openclaw/releases/tag/v1.2.0)                       |
| 2025-12-14 | 영속 워크스페이스의 전신                                               | [`v2.0.0-beta1`](https://github.com/openclaw/openclaw/releases/tag/v2.0.0-beta1)           |
| 2025-12-19 | 날짜별 일일 메모리                                                     | [`v2.0.0-beta2`](https://github.com/openclaw/openclaw/releases/tag/v2.0.0-beta2)           |
| 2025-12-20 | 소문자 영속 루트와 시간 범위                                           | `v2.0.0-beta2`                                                                             |
| 2025-12-23 | 오프라인 메모리 제안서                                                 | [`v2.0.0-beta3`](https://github.com/openclaw/openclaw/releases/tag/v2.0.0-beta3)           |
| 2026-01-03 | 외부 [QMD](01-current-architecture.md#qmd-explained) 프롬프트 워크플로 | [`v2.0.0-beta5`](https://github.com/openclaw/openclaw/releases/tag/v2.0.0-beta5)           |
| 2026-01-03 | 명시적인 “기록하라” 영속화 규칙                                        | [`v2026.1.5`](https://github.com/openclaw/openclaw/releases/tag/v2026.1.5)                 |
| 2026-01-06 | 선별·비공개 대문자 `MEMORY.md`와 하트비트 통합                         | [`v2026.1.8`](https://github.com/openclaw/openclaw/releases/tag/v2026.1.8)                 |
| 2026-01-07 | 수동 교차 세션 대화 기록 검색 스킬                                     | [`v2026.1.8`](https://github.com/openclaw/openclaw/releases/tag/v2026.1.8)                 |
| 2026-01-12 | 컴팩션 전 플러시                                                       | [`v2026.1.11`](https://github.com/openclaw/openclaw/releases/tag/v2026.1.11)               |
| 2026-01-12 | 네이티브 벡터 검색과 도구                                              | [`v2026.1.12`](https://github.com/openclaw/openclaw/releases/tag/v2026.1.12)               |
| 2026-01-17 | `/new` 세션 메모리 훅                                                  | [`v2026.1.16-2`](https://github.com/openclaw/openclaw/releases/tag/v2026.1.16-2)           |
| 2026-01-17 | sqlite-vec, 실험적 대화 기록 소스, 임베딩 캐시, 하이브리드 검색        | [`v2026.1.20`](https://github.com/openclaw/openclaw/releases/tag/v2026.1.20)               |
| 2026-01-18 | 배타적 메모리 슬롯과 LanceDB 플러그인                                  | `v2026.1.20`                                                                               |
| 2026-01-24 | 명시적 `none` 메모리 슬롯 비활성화 복구                                | [`v2026.1.23`](https://github.com/openclaw/openclaw/releases/tag/v2026.1.23)               |
| 2026-01-26 | `MEMORY.md` 런타임 부트스트랩                                          | [`v2026.1.29`](https://github.com/openclaw/openclaw/releases/tag/v2026.1.29)               |
| 2026-02-03 | 관리형 옵트인 QMD                                                      | [`v2026.2.2`](https://github.com/openclaw/openclaw/releases/tag/v2026.2.2)                 |
| 2026-02-13 | 덧붙이기 안전 플러시 프롬프트                                          | [`v2026.2.12`](https://github.com/openclaw/openclaw/releases/tag/v2026.2.12)               |
| 2026-02-16 | FTS 폴백, MMR, 시간 감쇠                                               | [`v2026.2.17`](https://github.com/openclaw/openclaw/releases/tag/v2026.2.17)               |
| 2026-02-21 | 세션 메모리 훅의 `/reset` 지원                                         | [`v2026.2.21-beta.1`](https://github.com/openclaw/openclaw/releases/tag/v2026.2.21-beta.1) |
| 2026-03-11 | 멀티모달 추가 경로 인덱싱                                              | [`v2026.3.11-beta.1`](https://github.com/openclaw/openclaw/releases/tag/v2026.3.11-beta.1) |
| 2026-03-26 | 플러그인 소유 엔진과 호스트 SDK 추출                                   | [`v2026.3.28-beta.1`](https://github.com/openclaw/openclaw/releases/tag/v2026.3.28-beta.1) |
| 2026-03-29 | CJK 인식 FTS 정체성                                                    | [`v2026.3.31-beta.1`](https://github.com/openclaw/openclaw/releases/tag/v2026.3.31-beta.1) |
| 2026-04-04 | Dreaming 회상 추적·승격                                                | [`v2026.4.5`](https://github.com/openclaw/openclaw/releases/tag/v2026.4.5)                 |
| 2026-04-06 | Memory Wiki 복원과 기능이 처음 포함된 릴리스                           | [`v2026.4.7`](https://github.com/openclaw/openclaw/releases/tag/v2026.4.7)                 |
| 2026-04-09 | Active Memory                                                          | [`v2026.4.10`](https://github.com/openclaw/openclaw/releases/tag/v2026.4.10)               |
| 2026-04-12 | 런타임 시작 시 일일 문맥                                               | [`v2026.4.12-beta.1`](https://github.com/openclaw/openclaw/releases/tag/v2026.4.12-beta.1) |
| 2026-04-23 | 런타임 루트를 대문자로만 제한하는 정책                                 | [`v2026.4.23-beta.1`](https://github.com/openclaw/openclaw/releases/tag/v2026.4.23-beta.1) |
| 2026-04-25 | 검색 후 세션 적중 가시성과 코퍼스 소스 선택                            | [`v2026.4.24-beta.1`](https://github.com/openclaw/openclaw/releases/tag/v2026.4.24-beta.1) |
| 2026-06-07 | Dreaming 기계 상태의 SQLite 이전                                       | [`v2026.6.7-alpha.1`](https://github.com/openclaw/openclaw/releases/tag/v2026.6.7-alpha.1) |
| 2026-06-18 | 인덱스를 에이전트별 SQLite로 이전                                      | [`v2026.6.9-beta.1`](https://github.com/openclaw/openclaw/releases/tag/v2026.6.9-beta.1)   |
| 2026-06-23 | 접근자 기반 대화 기록 코퍼스                                           | [`v2026.6.11-beta.1`](https://github.com/openclaw/openclaw/releases/tag/v2026.6.11-beta.1) |
| 2026-06-24 | Doctor의 레거시 독립 인덱스 가져오기                                   | [`v2026.7.1-beta.1`](https://github.com/openclaw/openclaw/releases/tag/v2026.7.1-beta.1)   |
| 2026-07-10 | 에이전트별 옵트인 Memory Wiki 볼트                                     | [`v2026.7.2-beta.1`](https://github.com/openclaw/openclaw/releases/tag/v2026.7.2-beta.1)   |
| 2026-07-11 | SQLite 세션과 정확 일치 `sessions_search`                              | [`v2026.7.2-beta.1`](https://github.com/openclaw/openclaw/releases/tag/v2026.7.2-beta.1)   |
| 2026-07-13 | Codex·Claude 메모리 가져오기                                           | `v2026.7.2-beta.1`                                                                         |
| 2026-07-16 | 원자적 승격과 LanceDB 소유권                                           | [`v2026.7.2-beta.2`](https://github.com/openclaw/openclaw/releases/tag/v2026.7.2-beta.2)   |
| 2026-07-16 | CLI·macOS·Linux 온보딩의 메모리 전용 가져오기와 Hermes 지원            | `v2026.7.2-beta.2`                                                                         |
| 2026-07-17 | QMD 조정, Memory Wiki 캐시, 런타임 저널의 SQLite 이전                  | `v2026.7.2-beta.3` / 런타임 저널은 `v2026.7.2-beta.4`                                      |
| 2026-07-18 | 보호된 교차 대화 회상과 기본값                                         | `v2026.7.2-beta.3` / 조건부 기본값은 `v2026.7.2-beta.4`                                    |

마지막 두 행은 아키텍처 기준일에 태그 밖이던 변경도 며칠 뒤 출시될 수 있음을 보여 준다. 역사를 재현하거나 특정 설치의 동작을 판단할 때는 고정 SHA와 태그 생성 시점을 함께 확인해야 한다. **마지막 출시 상태 검증: 2026-07-26.**

## 동기와 근거 색인

아래 표는 위의 41개 이정표와 같은 순서로 정확히 한 행씩 대응한다. **주된 변화 동기**는 확인된 변화가 풀려 한 문제를 짧게 적고, **동기 출처**는 0장에서 정의한 네 부류로 분류한다. **증거 강도·근거**는 동기를 뒷받침하는 주 증거를 표시한다. 현재 계약은 현재 시점의 상태를 확인하는 자료일 뿐 과거 동기의 증거로 세지 않았으며, 구현과 직접 연결되지 않은 유사 이슈는 맥락적·비인과라고 밝혔다.

### 2025-11-24 — 영속 세션 ID를 통한 연속성

- **커밋:** [`9b4dceecfe69`](https://github.com/openclaw/openclaw/commit/9b4dceecfe69bb224a369a33a1c064003040aedd)
- **최초 포함 태그:** [`v0.1.0`](https://github.com/openclaw/openclaw/releases/tag/v0.1.0)
- **해결하려 한 문제:** 발신자별 대화를 다시 이어 갈 수 있도록 라우팅·재개 상태를 보존한다.
- **동기 분류:** 설계·소유권 압력
- **근거 판정:** **코드에서 추론** — [커밋](https://github.com/openclaw/openclaw/commit/9b4dceecfe69bb224a369a33a1c064003040aedd)의 저장·재개 동작은 확인되지만 저자의 이유는 따로 적혀 있지 않다.

### 2025-11-27 — 사용자별 소문자 `memory.md` 시작 로딩

- **커밋:** [`c43cdc5ac3d3`](https://github.com/openclaw/openclaw/commit/c43cdc5ac3d3058238b1ea5579d4700e5345c3b2)
- **최초 포함 태그:** [`v1.2.0`](https://github.com/openclaw/openclaw/releases/tag/v1.2.0)
- **해결하려 한 문제:** 사용자별 내구성 문맥이 새 세션의 인지에 다시 들어오게 한다.
- **동기 분류:** 설계·소유권 압력
- **근거 판정:** **코드에서 추론** — [커밋](https://github.com/openclaw/openclaw/commit/c43cdc5ac3d3058238b1ea5579d4700e5345c3b2)의 시작 지침에서 가장 좁게 추론했다.

### 2025-12-14 — 영속 워크스페이스의 전신

- **커밋:** [`073285409b4c`](https://github.com/openclaw/openclaw/commit/073285409b4cd24eb7888832b917f423b20b6d10)
- **최초 포함 태그:** [`v2.0.0-beta1`](https://github.com/openclaw/openclaw/releases/tag/v2.0.0-beta1)
- **해결하려 한 문제:** 에이전트의 노트·파일·기억을 사용자가 소유하고 백업할 수 있는 워크스페이스에 모은다.
- **동기 분류:** 설계·소유권 압력
- **근거 판정:** **코드에서 추론** — [커밋](https://github.com/openclaw/openclaw/commit/073285409b4cd24eb7888832b917f423b20b6d10)의 템플릿과 저장 경계가 근거다.

### 2025-12-19 — 날짜별 일일 메모리

- **커밋:** [`590f3d0e8f28`](https://github.com/openclaw/openclaw/commit/590f3d0e8f285d02e594cd718bfe9350ea5ee267)
- **최초 포함 태그:** [`v2.0.0-beta2`](https://github.com/openclaw/openclaw/releases/tag/v2.0.0-beta2)
- **해결하려 한 문제:** 최근 사실과 결정을 날짜별로 누적해 시작 시 다시 읽을 수 있는 일관된 관례를 만든다.
- **동기 분류:** 설계·소유권 압력
- **근거 판정:** **코드에서 추론** — [커밋](https://github.com/openclaw/openclaw/commit/590f3d0e8f285d02e594cd718bfe9350ea5ee267)의 템플릿 계약에서 추론했다.

### 2025-12-20 — 소문자 영속 루트와 시간 범위

- **커밋:** [`cfd3efb6e767`](https://github.com/openclaw/openclaw/commit/cfd3efb6e767bcab8bbc2617913be2259e953bbb)
- **최초 포함 태그:** `v2.0.0-beta2`
- **해결하려 한 문제:** 자세한 일일 기록과 압축된 장기 사실을 서로 다른 시간 범위로 분리한다.
- **동기 분류:** 설계·소유권 압력
- **근거 판정:** **코드에서 추론** — [커밋](https://github.com/openclaw/openclaw/commit/cfd3efb6e767bcab8bbc2617913be2259e953bbb)의 두 파일 역할이 근거다.

### 2025-12-23 — 오프라인 메모리 제안서

- **커밋:** [`760a83d256d6`](https://github.com/openclaw/openclaw/commit/760a83d256d63b55905681cadac60bebca684b73)
- **최초 포함 태그:** [`v2.0.0-beta3`](https://github.com/openclaw/openclaw/releases/tag/v2.0.0-beta3)
- **해결하려 한 문제:** 일일 Markdown의 회상·엔터티·시간 충돌 한계를 오프라인 우선의 설명 가능한 검색·통합으로 보완한다.
- **동기 분류:** 설계·소유권 압력
- **근거 판정:** **명시적** — [제안서 커밋](https://github.com/openclaw/openclaw/commit/760a83d256d63b55905681cadac60bebca684b73)이 문제, 목표, 단계, 채택하지 않을 범위를 직접 적는다.

### 2026-01-03 — 외부 QMD 프롬프트 워크플로

- **커밋:** [`7e4e9ecdeaf8`](https://github.com/openclaw/openclaw/commit/7e4e9ecdeaf8849dbe464f31e50f4932c88904a3)
- **최초 포함 태그:** [`v2.0.0-beta5`](https://github.com/openclaw/openclaw/releases/tag/v2.0.0-beta5)
- **해결하려 한 문제:** 제품 내장 엔진이 없던 시점에 로컬 의미 검색으로 늘어난 Markdown을 찾는다.
- **동기 분류:** 설계·소유권 압력
- **근거 판정:** **코드에서 추론** — [커밋](https://github.com/openclaw/openclaw/commit/7e4e9ecdeaf8849dbe464f31e50f4932c88904a3)은 기능을 말하지만 저자의 선택 이유는 밝히지 않는다.

### 2026-01-03 — 명시적인 “기록하라” 영속화 규칙

- **커밋:** [`c2a74d6d2a1b`](https://github.com/openclaw/openclaw/commit/c2a74d6d2a1bd57889ff4bb1d7e43621f49e3c63)
- **최초 포함 태그:** [`v2026.1.5`](https://github.com/openclaw/openclaw/releases/tag/v2026.1.5)
- **해결하려 한 문제:** 세션이 끝나면 사라지는 머릿속 메모 대신 내구성 있는 파일 기록을 요구한다.
- **동기 분류:** 설계·소유권 압력
- **근거 판정:** **명시적** — [커밋 본문](https://github.com/openclaw/openclaw/commit/c2a74d6d2a1bd57889ff4bb1d7e43621f49e3c63)이 “세션을 넘지 못하는 정신적 메모”를 이유로 든다.

### 2026-01-06 — 선별·비공개 대문자 `MEMORY.md`와 하트비트 통합

- **커밋:** [`7d1fee70e76f`](https://github.com/openclaw/openclaw/commit/7d1fee70e76f2f634f1b41fca927ee663914183a), [`9ffea23f31ca`](https://github.com/openclaw/openclaw/commit/9ffea23f31ca1df5183b25668f8f814bee0fb34e)
- **최초 포함 태그:** [`v2026.1.8`](https://github.com/openclaw/openclaw/releases/tag/v2026.1.8)
- **해결하려 한 문제:** 원시 일지에서 장기 사실을 선별하되 개인 문맥이 공유 맥락으로 새지 않게 한다.
- **동기 분류:** 설계·소유권 압력
- **근거 판정:** **명시적** — [도입 커밋](https://github.com/openclaw/openclaw/commit/7d1fee70e76f2f634f1b41fca927ee663914183a)과 [유지보수 커밋](https://github.com/openclaw/openclaw/commit/9ffea23f31ca1df5183b25668f8f814bee0fb34e)이 보안·선별 의도를 직접 밝힌다.

### 2026-01-07 — 수동 교차 세션 대화 기록 검색 스킬

- **커밋:** [`388796253a03`](https://github.com/openclaw/openclaw/commit/388796253a0380f47cae15a434f1f1e33b034ce1)
- **최초 포함 태그:** [`v2026.1.8`](https://github.com/openclaw/openclaw/releases/tag/v2026.1.8)
- **해결하려 한 문제:** 의미 메모리에 없는 과거 발화와 사용 내역을 대화 기록에서 직접 찾는다.
- **동기 분류:** 설계·소유권 압력
- **근거 판정:** **코드에서 추론** — [커밋](https://github.com/openclaw/openclaw/commit/388796253a0380f47cae15a434f1f1e33b034ce1)의 검색 기능은 확인되지만 사용자 사건과의 연결은 없다.

### 2026-01-12 — 컴팩션 전 플러시

- **커밋:** [`7dbb21be8e57`](https://github.com/openclaw/openclaw/commit/7dbb21be8e5778deeb63ed3db9abc243ffa83cac)
- **최초 포함 태그:** [`v2026.1.11`](https://github.com/openclaw/openclaw/releases/tag/v2026.1.11)
- **해결하려 한 문제:** 컴팩션으로 문맥이 사라지기 직전에 의미 메모리를 기록할 마지막 기회를 보장한다.
- **동기 분류:** 설계·소유권 압력
- **근거 판정:** **코드에서 추론** — [커밋](https://github.com/openclaw/openclaw/commit/7dbb21be8e5778deeb63ed3db9abc243ffa83cac)의 실행 시점과 앞선 헤드룸 변경에서 좁게 추론했다.

### 2026-01-12 — 네이티브 벡터 검색과 도구

- **커밋:** [`bf11a42c372b`](https://github.com/openclaw/openclaw/commit/bf11a42c372b72cbe030c05b80e18f42dd9fdd59)
- **최초 포함 태그:** [`v2026.1.12`](https://github.com/openclaw/openclaw/releases/tag/v2026.1.12)
- **해결하려 한 문제:** 늘어난 의미 메모리를 모델이 경로를 몰라도 관련도 기반으로 찾아 원문까지 가져오게 한다.
- **동기 분류:** 설계·소유권 압력
- **근거 판정:** **코드에서 추론** — [구현 커밋](https://github.com/openclaw/openclaw/commit/bf11a42c372b72cbe030c05b80e18f42dd9fdd59)이 동작은 입증한다. [이슈 #102](https://github.com/openclaw/openclaw/issues/102)는 같은 요구를 말하지만 직접 연결이 없어 **맥락적·비인과**다.

### 2026-01-17 — `/new` 세션 메모리 훅

- **커밋:** [`faba508fe0ae`](https://github.com/openclaw/openclaw/commit/faba508fe0ae4dd4de453f4eccb62e452950880d)
- **최초 포함 태그:** [`v2026.1.16-2`](https://github.com/openclaw/openclaw/releases/tag/v2026.1.16-2)
- **해결하려 한 문제:** 새 세션 경계에서 최근 대화의 제한된 꼬리를 기계적으로 보존한다.
- **동기 분류:** 설계·소유권 압력
- **근거 판정:** **코드에서 추론** — [커밋](https://github.com/openclaw/openclaw/commit/faba508fe0ae4dd4de453f4eccb62e452950880d)의 훅과 포획 동작이 근거이며 별도 동기 서술은 없다.

### 2026-01-17 — sqlite-vec, 실험적 대화 기록 소스, 임베딩 캐시, 하이브리드 검색

- **커밋:** [`5a08471dcd1b`](https://github.com/openclaw/openclaw/commit/5a08471dcd1b92e87d4c7d87dbd0b7b3a5723784), [`0e49dca53c3b`](https://github.com/openclaw/openclaw/commit/0e49dca53c3be33a40565f653e38bd966181b639), [`0fb2777c6de9`](https://github.com/openclaw/openclaw/commit/0fb2777c6de919673b62dad9208dcb47784895b9), [`ccb30665f7c5`](https://github.com/openclaw/openclaw/commit/ccb30665f7c5e2e386aa5db28f4c8c461ca60773)
- **최초 포함 태그:** [`v2026.1.20`](https://github.com/openclaw/openclaw/releases/tag/v2026.1.20)
- **해결하려 한 문제:** 검색 속도·임베딩 비용·어휘/의미 순위화와 대화 기록 코퍼스 범위를 함께 보완한다.
- **동기 분류:** 설계·소유권 압력
- **근거 판정:** **코드에서 추론** — [sqlite-vec](https://github.com/openclaw/openclaw/commit/5a08471dcd1b92e87d4c7d87dbd0b7b3a5723784), [대화 기록 소스](https://github.com/openclaw/openclaw/commit/0e49dca53c3be33a40565f653e38bd966181b639), [임베딩 캐시](https://github.com/openclaw/openclaw/commit/0fb2777c6de919673b62dad9208dcb47784895b9), [하이브리드 검색](https://github.com/openclaw/openclaw/commit/ccb30665f7c5e2e386aa5db28f4c8c461ca60773)의 결합에서 도출했으며, 단일 원인이나 운영 측정은 확인되지 않았다.

### 2026-01-18 — 배타적 메모리 슬롯과 LanceDB 플러그인

- **커밋:** [`9fd9f4c8962e`](https://github.com/openclaw/openclaw/commit/9fd9f4c8962eb2f783db791cc0a62e290183cc77), [`ebfeb7a6bf53`](https://github.com/openclaw/openclaw/commit/ebfeb7a6bf533b733d2a08a527dc77f4ae793900)
- **최초 포함 태그:** `v2026.1.20`
- **해결하려 한 문제:** 자동 회상·포획을 제공하는 대안 저장소를 허용하되 한 공급자만 메모리 기능을 소유하게 한다.
- **동기 분류:** 사용자·유지보수자 요청, 설계·소유권 압력
- **근거 판정:** **명시적** — [PR #808의 유지보수자 답변](https://github.com/openclaw/openclaw/pull/808#issuecomment-3764762140)이 “한 번에 하나의 메모리 공급자”를 위한 슬롯을 직접 연결한다.

### 2026-01-24 — 명시적 `none` 메모리 슬롯 비활성화 복구

- **커밋:** [`c4c01089ab9b`](https://github.com/openclaw/openclaw/commit/c4c01089ab9b8c8f3f23286859a3fadf7445bd4a)
- **최초 포함 태그:** [`v2026.1.23`](https://github.com/openclaw/openclaw/releases/tag/v2026.1.23)
- **해결하려 한 문제:** 사용자가 끈 메모리 슬롯을 기본 플러그인으로 되살리던 정규화 회귀를 바로잡는다.
- **동기 분류:** 장애·회귀·폴백 사건
- **근거 판정:** **명시적** — [수정 커밋](https://github.com/openclaw/openclaw/commit/c4c01089ab9b8c8f3f23286859a3fadf7445bd4a)이 `none`을 존중해야 한다고 직접 밝힌다.

### 2026-01-26 — `MEMORY.md` 런타임 부트스트랩

- **커밋:** [`2cbc991bfe7c`](https://github.com/openclaw/openclaw/commit/2cbc991bfe7cdc8a722fc98d419826c982b06231)
- **최초 포함 태그:** [`v2026.1.29`](https://github.com/openclaw/openclaw/releases/tag/v2026.1.29)
- **해결하려 한 문제:** 임베딩 공급자가 없어도 존재하는 선별 메모리를 “비어 있음”으로 오인하지 않게 한다.
- **동기 분류:** 장애·회귀·폴백 사건
- **근거 판정:** **명시적** — [PR #2318](https://github.com/openclaw/openclaw/pull/2318)이 공급자 미설정 실패와 부트스트랩 해법을 직접 설명한다.

### 2026-02-03 — 관리형 옵트인 QMD

- **커밋:** [`5d3af3bc6226`](https://github.com/openclaw/openclaw/commit/5d3af3bc6226026826c5eef48e2ad2eb9f6a01f2)
- **최초 포함 태그:** [`v2026.2.2`](https://github.com/openclaw/openclaw/releases/tag/v2026.2.2)
- **해결하려 한 문제:** 외부 QMD의 컬렉션·갱신·프로세스·경로 안전·폴백을 제품이 관리하는 선택 백엔드로 묶는다.
- **동기 분류:** 설계·소유권 압력
- **근거 판정:** **명시된 계약과 코드 추론** — [PR #3160](https://github.com/openclaw/openclaw/pull/3160)은 옵트인 백엔드 범위와 QMD 누락·오동작 때의 내장 폴백을 직접 적는다. 다만 외부 도구를 제품 수명주기 안에 묶은 더 깊은 선택 이유와 특정 폴백 사건은 제시하지 않는다.

### 2026-02-13 — 덧붙이기 안전 플러시 프롬프트

- **커밋:** [`da2d09f57a0a`](https://github.com/openclaw/openclaw/commit/da2d09f57a0aa272e15ce4c645857d8f650a0407)
- **최초 포함 태그:** [`v2026.2.12`](https://github.com/openclaw/openclaw/releases/tag/v2026.2.12)
- **해결하려 한 문제:** 플러시가 기존 일일 파일을 통째로 덮어써 앞선 기록을 잃는 사고를 막는다.
- **동기 분류:** 장애·회귀·폴백 사건
- **근거 판정:** **명시적** — [이슈 #6877](https://github.com/openclaw/openclaw/issues/6877)의 Git 이력 데이터 손실과 [PR #6878](https://github.com/openclaw/openclaw/pull/6878)의 수정이 직접 연결된다.

### 2026-02-16 — FTS 폴백, MMR, 시간 감쇠

- **커밋:** [`65aedac20e53`](https://github.com/openclaw/openclaw/commit/65aedac20e535bea40a74a5f96f988738a5a8307), [`fa9420069ab3`](https://github.com/openclaw/openclaw/commit/fa9420069ab39f36fc47ca23b0ea909025a0a447), [`6b3e0710f4a0`](https://github.com/openclaw/openclaw/commit/6b3e0710f4a05135fa57798dcc3ff9668e6a061a)
- **최초 포함 태그:** [`v2026.2.17`](https://github.com/openclaw/openclaw/releases/tag/v2026.2.17)
- **해결하려 한 문제:** 공급자 부재에도 검색을 유지하고, 중복 결과와 오래된 일일 기록의 순위 편향을 선택적으로 조정한다.
- **동기 분류:** 장애·회귀·폴백 사건, 설계·소유권 압력
- **근거 판정:** **명시적** — [Issue #17725](https://github.com/openclaw/openclaw/issues/17725)와 [FTS 폴백](https://github.com/openclaw/openclaw/commit/65aedac20e535bea40a74a5f96f988738a5a8307)은 공급자 부재로 검색이 꺼진 사용자 보고와 수정을 직접 잇는다. [MMR](https://github.com/openclaw/openclaw/commit/fa9420069ab39f36fc47ca23b0ea909025a0a447), [시간 감쇠](https://github.com/openclaw/openclaw/commit/6b3e0710f4a05135fa57798dcc3ff9668e6a061a), [PR #13391](https://github.com/openclaw/openclaw/pull/13391)은 중복 감소와 선택적 최신성이라는 별도 설계 목표를 밝힌다.

### 2026-02-21 — 세션 메모리 훅의 `/reset` 지원

- **커밋:** [`d583399c9240`](https://github.com/openclaw/openclaw/commit/d583399c92401f64261da28a6531f72f052e96d8)
- **최초 포함 태그:** [`v2026.2.21-beta.1`](https://github.com/openclaw/openclaw/releases/tag/v2026.2.21-beta.1)
- **해결하려 한 문제:** `/new`와 `/reset`의 기계적 포획 수명주기를 맞춘다.
- **동기 분류:** 설계·소유권 압력
- **근거 판정:** **코드에서 추론** — [커밋](https://github.com/openclaw/openclaw/commit/d583399c92401f64261da28a6531f72f052e96d8)에서 좁게 추론했다. [이슈 #45608](https://github.com/openclaw/openclaw/issues/45608)은 남은 의미 플러시 비대칭을 다룰 뿐 이 구현 원인의 증거는 아니므로 **맥락적·비인과**다.

### 2026-03-11 — 멀티모달 추가 경로 인덱싱

- **커밋:** [`d79ca5296054`](https://github.com/openclaw/openclaw/commit/d79ca5296054058930bd97dd43540fd52ede15a3)
- **최초 포함 태그:** [`v2026.3.11-beta.1`](https://github.com/openclaw/openclaw/releases/tag/v2026.3.11-beta.1)
- **해결하려 한 문제:** 기본 Markdown 경계를 넓히지 않고 명시적으로 고른 이미지·오디오 코퍼스만 검색에 넣는다.
- **동기 분류:** 설계·소유권 압력
- **근거 판정:** **명시된 목표와 코드 추론** — [PR #43460](https://github.com/openclaw/openclaw/pull/43460)은 이미지·오디오 색인, 옵트인 추가 경로, Gemini 제한, 실패 시 닫힘을 직접 적는다. 비용·프라이버시 때문에 그 범위를 골랐다는 해석은 구현 경계에서 추론하며, 실제 무단 수집 사건은 확인되지 않았다.

### 2026-03-26 — 플러그인 소유 엔진과 호스트 SDK 추출

- **커밋:** [`cad83db8b2f7`](https://github.com/openclaw/openclaw/commit/cad83db8b2f7664230df50f63cfff3106a5a8154), [`bd6c7969ea9c`](https://github.com/openclaw/openclaw/commit/bd6c7969ea9c40c56ccdbe50301aeb8621321ba4)
- **최초 포함 태그:** [`v2026.3.28-beta.1`](https://github.com/openclaw/openclaw/releases/tag/v2026.3.28-beta.1)
- **해결하려 한 문제:** 일반 에이전트 코어에서 메모리 정책을 걷어 내고 선택된 플러그인과 안정된 호스트 경계에 맡긴다.
- **동기 분류:** 설계·소유권 압력
- **근거 판정:** **코드에서 추론** — [엔진 이동](https://github.com/openclaw/openclaw/commit/cad83db8b2f7664230df50f63cfff3106a5a8154)과 [SDK 추출](https://github.com/openclaw/openclaw/commit/bd6c7969ea9c40c56ccdbe50301aeb8621321ba4)의 소유권 이동에서 추론했다.

### 2026-03-29 — CJK 인식 FTS 정체성

- **커밋:** [`3ce48aff660a`](https://github.com/openclaw/openclaw/commit/3ce48aff660a0dca487fb195132d53e6e0e404ed)
- **최초 포함 태그:** [`v2026.3.31-beta.1`](https://github.com/openclaw/openclaw/releases/tag/v2026.3.31-beta.1)
- **해결하려 한 문제:** 기본 FTS5 토큰화가 CJK 부분 문자열을 찾지 못해 BM25가 사실상 무력해지는 실패를 고친다.
- **동기 분류:** 사용자·유지보수자 요청, 장애·회귀·폴백 사건
- **근거 판정:** **명시적** — [이슈 #20730](https://github.com/openclaw/openclaw/issues/20730)의 재현과 [PR #56707](https://github.com/openclaw/openclaw/pull/56707)의 토크나이저·재인덱싱 계약이 직접 연결된다.

### 2026-04-04 — Dreaming 회상 추적·승격

- **커밋:** [`4c1022c73b39`](https://github.com/openclaw/openclaw/commit/4c1022c73b3910ed68d0c4c72767e7465067c6a7)
- **최초 포함 태그:** [`v2026.4.5`](https://github.com/openclaw/openclaw/releases/tag/v2026.4.5)
- **해결하려 한 문제:** 반복해 유용하게 회상된 작업 메모리를 점수화해 검토·승격할 수 있게 한다.
- **동기 분류:** 설계·소유권 압력
- **근거 판정:** **명시된 목표와 코드 추론** — [PR #60569](https://github.com/openclaw/openclaw/pull/60569)은 회상 기록, 가중 신호, 초기 임계값, 수동·예약 승격 흐름을 직접 적지만 왜 그 신호와 수치를 선택했는지는 설명하지 않는다. [이슈 #102](https://github.com/openclaw/openclaw/issues/102)의 장기 승격 요구는 연결이 없어 **맥락적·비인과**다.

### 2026-04-06 — Memory Wiki 복원과 기능이 처음 포함된 릴리스

- **커밋:** [`5716d83336fd`](https://github.com/openclaw/openclaw/commit/5716d83336fd3411ba515659af4879ae8518563f)
- **최초 포함 태그:** [`v2026.4.7`](https://github.com/openclaw/openclaw/releases/tag/v2026.4.7)
- **해결하려 한 문제:** 평면 노트 옆에 출처·관계·모순을 표현할 선택적 구조화 지식 계층을 다시 제공한다.
- **동기 분류:** 설계·소유권 압력
- **근거 판정:** **코드에서 추론** — [복원 커밋](https://github.com/openclaw/openclaw/commit/5716d83336fd3411ba515659af4879ae8518563f)과 되돌림·복원 계보는 확인되지만 복원 이유를 직접 적은 1차 서술은 없다.

### 2026-04-09 — Active Memory

- **커밋:** [`b83726d13e33`](https://github.com/openclaw/openclaw/commit/b83726d13e336643d0b68d8aae79f222b8d26e90)
- **최초 포함 태그:** [`v2026.4.10`](https://github.com/openclaw/openclaw/releases/tag/v2026.4.10)
- **해결하려 한 문제:** 주 모델이 메모리 도구를 호출하기를 기다리지 않고 응답 전에 제한된 회상을 수행한다.
- **동기 분류:** 사용자·유지보수자 요청
- **근거 판정:** **명시적** — [PR #63286](https://github.com/openclaw/openclaw/pull/63286)이 “도구 사용을 주 모델에 의존하지 않는다”는 이유와 사용자 효과를 직접 밝힌다.

### 2026-04-12 — 런타임 시작 시 일일 문맥

- **커밋:** [`94340b959830`](https://github.com/openclaw/openclaw/commit/94340b959830b8d7dd70d486617963ad2999409c)
- **최초 포함 태그:** [`v2026.4.12-beta.1`](https://github.com/openclaw/openclaw/releases/tag/v2026.4.12-beta.1)
- **해결하려 한 문제:** 모델의 시작 절차 이행 여부 대신 런타임이 최근 일일 노트를 결정적으로 주입한다.
- **동기 분류:** 설계·소유권 압력
- **근거 판정:** **명시적** — [PR #65055](https://github.com/openclaw/openclaw/pull/65055)이 모델 자율 동작에서 런타임으로 옮긴 이유를 직접 적는다. [이슈 #48217](https://github.com/openclaw/openclaw/issues/48217)은 연결되지 않은 **맥락적·비인과** 사례다.

### 2026-04-23 — 런타임 루트를 대문자로만 제한하는 정책

- **커밋:** [`10a9acbf2936`](https://github.com/openclaw/openclaw/commit/10a9acbf29361744ff8a9920cc07c7d285e831bd)
- **최초 포함 태그:** [`v2026.4.23-beta.1`](https://github.com/openclaw/openclaw/releases/tag/v2026.4.23-beta.1)
- **해결하려 한 문제:** 소문자·대문자 장기 파일의 분할 상태와 가려진 오래된 메모리를 doctor에서 수리하고 정본을 하나로 만든다.
- **동기 분류:** 장애·회귀·폴백 사건, 설계·소유권 압력
- **근거 판정:** **명시적** — [PR #70621](https://github.com/openclaw/openclaw/pull/70621)이 실제 분할 상태, 가려짐, 수리 부재를 직접 설명한다.

### 2026-04-25 — 검색 후 세션 적중 가시성과 코퍼스 소스 선택

- **커밋:** [`2c716f5677de`](https://github.com/openclaw/openclaw/commit/2c716f5677de4db99ecaab058b4f375009468c86)
- **최초 포함 태그:** [`v2026.4.24-beta.1`](https://github.com/openclaw/openclaw/releases/tag/v2026.4.24-beta.1)
- **해결하려 한 문제:** 대화 기록 기반 결과가 세션 도구의 가시성과 에이전트 간 정책을 우회해 노출·학습되는 경로를 막는다.
- **동기 분류:** 장애·회귀·폴백 사건
- **근거 판정:** **명시적** — [PR #70761](https://github.com/openclaw/openclaw/pull/70761)이 우회 경로, 실패 시 닫힘, 인용·회상 추적 전 검색 후 필터를 직접 설명한다.

### 2026-06-07 — Dreaming 기계 상태의 SQLite 이전

- **커밋:** [`3f5e00184431`](https://github.com/openclaw/openclaw/commit/3f5e00184431f10a7ae55c59ce8d3c6cb0d0a0eb)
- **최초 포함 태그:** [`v2026.6.7-alpha.1`](https://github.com/openclaw/openclaw/releases/tag/v2026.6.7-alpha.1)
- **해결하려 한 문제:** 체크포인트·잠금·회상 횟수의 런타임 소유자를 파일 곁가지에서 SQLite 플러그인 상태로 모은다.
- **동기 분류:** 설계·소유권 압력
- **근거 판정:** **코드에서 추론** — [PR #91056](https://github.com/openclaw/openclaw/pull/91056)은 이동과 마이그레이션을 입증하지만 별도의 사용자 사건이나 저자 이유는 제시하지 않는다.

### 2026-06-18 — 인덱스를 에이전트별 SQLite로 이전

- **커밋:** [`f324f7e2813a`](https://github.com/openclaw/openclaw/commit/f324f7e2813a52e07c515143e041be6ce7bca1d3)
- **최초 포함 태그:** [`v2026.6.9-beta.1`](https://github.com/openclaw/openclaw/releases/tag/v2026.6.9-beta.1)
- **해결하려 한 문제:** 독립 곁가지 인덱스를 에이전트 소유 데이터베이스에 합쳐 백업·권한·정리를 한 경계로 맞춘다.
- **동기 분류:** 설계·소유권 압력
- **근거 판정:** **코드에서 추론** — [PR #94646](https://github.com/openclaw/openclaw/pull/94646)은 데이터베이스 우선 정렬과 호환 범위를 입증하지만, 백업·권한·정리를 한 경계로 모은다는 동기는 코드와 소유권 규칙에서 추론했다.

### 2026-06-23 — 접근자 기반 대화 기록 코퍼스

- **커밋:** [`c24d266b2d09`](https://github.com/openclaw/openclaw/commit/c24d266b2d0943a2376ae9ac87a2fd8e200920e1)
- **최초 포함 태그:** [`v2026.6.11-beta.1`](https://github.com/openclaw/openclaw/releases/tag/v2026.6.11-beta.1)
- **해결하려 한 문제:** 여러 소비자가 저장 배치를 다시 발견하지 않도록 세션·에이전트·산출물 정체성을 정식 접근자가 운반한다.
- **동기 분류:** 설계·소유권 압력
- **근거 판정:** **명시적** — [PR #96162](https://github.com/openclaw/openclaw/pull/96162)이 저장 배치 가정을 소비자마다 되풀이하던 문제와 정식 접근자 경계로 옮긴 이유를 직접 설명한다.

### 2026-06-24 — Doctor의 레거시 독립 인덱스 가져오기

- **커밋:** [`414c250af90d`](https://github.com/openclaw/openclaw/commit/414c250af90d0e19d44b407cf31b32a2221956c4)
- **최초 포함 태그:** [`v2026.7.1-beta.1`](https://github.com/openclaw/openclaw/releases/tag/v2026.7.1-beta.1)
- **해결하려 한 문제:** 저장소 이동이 1,499개 파일의 재임베딩을 강제하고 경고도 없었던 업그레이드 회귀를 수리한다.
- **동기 분류:** 장애·회귀·폴백 사건, 운영 측정
- **근거 판정:** **명시적** — [이슈 #95495](https://github.com/openclaw/openclaw/issues/95495)의 파일·청크·저장소 수치와 [PR #95631](https://github.com/openclaw/openclaw/pull/95631)의 doctor 마이그레이션이 직접 연결된다.

### 2026-07-10 — 에이전트별 옵트인 Memory Wiki 볼트

- **커밋:** [`98b8c8c4ae29`](https://github.com/openclaw/openclaw/commit/98b8c8c4ae298c55ad42a99020ee689b1c3ed1c1)
- **최초 포함 태그:** [`v2026.7.2-beta.1`](https://github.com/openclaw/openclaw/releases/tag/v2026.7.2-beta.1)
- **해결하려 한 문제:** 여러 에이전트가 하나의 볼트를 공유해 검색·프롬프트 문맥이 섞이는 문제를 격리한다.
- **동기 분류:** 장애·회귀·폴백 사건, 설계·소유권 압력
- **근거 판정:** **명시적** — [PR #103349](https://github.com/openclaw/openclaw/pull/103349)이 공유 볼트 문제와 에이전트별 실패 시 닫힘을 직접 설명한다.

### 2026-07-11 — SQLite 세션과 정확 일치 `sessions_search`

- **커밋:** [`0a8e3604ba24`](https://github.com/openclaw/openclaw/commit/0a8e3604ba24de4791d3505b7a442e8017276dd0), [`6fc564278dbb`](https://github.com/openclaw/openclaw/commit/6fc564278dbb61691b0b07ec269b0bb60d225111)
- **최초 포함 태그:** [`v2026.7.2-beta.1`](https://github.com/openclaw/openclaw/releases/tag/v2026.7.2-beta.1)
- **해결하려 한 문제:** 세션·대화 기록의 정본을 SQLite로 통합하고, 키를 미리 몰라도 과거 발화를 정확 검색하게 한다.
- **동기 분류:** 사용자·유지보수자 요청, 설계·소유권 압력
- **근거 판정:** **명시적** — [PR #98236](https://github.com/openclaw/openclaw/pull/98236)의 혼합 저장소 드리프트와 [이슈 #100978](https://github.com/openclaw/openclaw/issues/100978)·[PR #105057](https://github.com/openclaw/openclaw/pull/105057)의 검색 공백이 직접 서술된다.

### 2026-07-13 — Codex·Claude 메모리 가져오기

- **커밋:** [`4319ddbe8cb0`](https://github.com/openclaw/openclaw/commit/4319ddbe8cb08a49335eff22b82e3a7afe3d3201)
- **최초 포함 태그:** `v2026.7.2-beta.1`
- **해결하려 한 문제:** 다른 코딩 에이전트의 내구성 Markdown을 수동 복사 없이 검토·복구 가능한 방식으로 옮긴다.
- **동기 분류:** 사용자·유지보수자 요청
- **근거 판정:** **명시적** — [이슈 #106215](https://github.com/openclaw/openclaw/issues/106215)와 [PR #106406](https://github.com/openclaw/openclaw/pull/106406)이 수동 복사·충돌·백업 공백을 직접 연결한다.

### 2026-07-16 — 원자적 승격과 LanceDB 소유권

- **커밋:** [`0317d7e62801`](https://github.com/openclaw/openclaw/commit/0317d7e628010d6e51a2a09f9d7e9af677216981), [`6390edec25e2`](https://github.com/openclaw/openclaw/commit/6390edec25e2614962a424f555ca7616eca8b340)
- **최초 포함 태그:** [`v2026.7.2-beta.2`](https://github.com/openclaw/openclaw/releases/tag/v2026.7.2-beta.2)
- **해결하려 한 문제:** 자동 승격 중 파일 절단과 공유 LanceDB의 에이전트 간 읽기·삭제·회상 누출을 함께 막는다.
- **동기 분류:** 장애·회귀·폴백 사건, 설계·소유권 압력
- **근거 판정:** **명시적** — [원자적 쓰기 커밋](https://github.com/openclaw/openclaw/commit/0317d7e628010d6e51a2a09f9d7e9af677216981)은 부분 쓰기 때 생길 수 있는 절단 경로와 원자적 수정을 입증하지만 실제 손실 보고를 제시하지는 않는다. [이슈 #103590](https://github.com/openclaw/openclaw/issues/103590)은 `v2026.6.11`의 개인 메모리 교차 에이전트 자동 회상 누출을 재현했고 [PR #103799](https://github.com/openclaw/openclaw/pull/103799)가 이를 닫았다. 소유자가 없는 기존 행은 doctor가 소유권을 입증하지 않고 설정된 기본 에이전트에 일괄 할당한다.

### 2026-07-16 — CLI·macOS·Linux 온보딩의 메모리 전용 가져오기와 Hermes 지원

- **커밋:** [`e71ef76e8ed7`](https://github.com/openclaw/openclaw/commit/e71ef76e8ed74179699af1feacbd5a9042345c1c)
- **최초 포함 태그:** `v2026.7.2-beta.2`
- **해결하려 한 문제:** 기존 기억이 감지되어도 온보딩에서 가져올 수 없던 표면 공백을 모든 로컬 설치 흐름에서 닫는다.
- **동기 분류:** 사용자·유지보수자 요청
- **근거 판정:** **명시적** — [PR #108977](https://github.com/openclaw/openclaw/pull/108977)이 각 온보딩 표면의 공백과 Hermes의 메모리 전용 가져오기 제약을 직접 설명한다.

### 2026-07-17 — QMD 조정, Memory Wiki 캐시, 런타임 저널의 SQLite 이전

- **커밋:** [`e873a7f955f8`](https://github.com/openclaw/openclaw/commit/e873a7f955f8b354b8d0d3cb82da1da3dc5b161b), [`d8f2645c2ced`](https://github.com/openclaw/openclaw/commit/d8f2645c2cedbe1f8986a01974c5f6e45dbbf652), [`9d97e10efe08`](https://github.com/openclaw/openclaw/commit/9d97e10efe08c3b5e3043da19b80883e933e26be)
- **최초 포함 태그:** QMD 조정과 Memory Wiki 캐시는 `v2026.7.2-beta.3`, 런타임 저널은 `v2026.7.2-beta.4`
- **해결하려 한 문제:** 잠금·캐시·저널의 파일 상태와 분산된 정리 책임을 각 SQLite 소유자와 수명주기에 맞춘다.
- **동기 분류:** 설계·소유권 압력
- **근거 판정:** **명시적** — [PR #109636](https://github.com/openclaw/openclaw/pull/109636), [PR #110167](https://github.com/openclaw/openclaw/pull/110167), [PR #109427](https://github.com/openclaw/openclaw/pull/109427)이 각 파일 상태의 문제와 SQLite 소유자를 직접 밝힌다.

### 2026-07-18 — 보호된 교차 대화 회상과 기본값

- **커밋:** [`4b3ee5e7eb62`](https://github.com/openclaw/openclaw/commit/4b3ee5e7eb623368d367a5fc2fa3712bc8095f16), [`01a9e1d398fd`](https://github.com/openclaw/openclaw/commit/01a9e1d398fd12970e936335811f13ee913e29c1)
- **최초 포함 태그:** 보호된 회상은 `v2026.7.2-beta.3`, 조건부 기본값은 `v2026.7.2-beta.4`
- **해결하려 한 문제:** 개인 에이전트의 사적 대화 간 망각을 줄이되 다중 사용자형 격리가 감지되면 기본으로 닫는다.
- **동기 분류:** 사용자·유지보수자 요청, 설계·소유권 압력
- **근거 판정:** **명시적** — [이슈 #99611](https://github.com/openclaw/openclaw/issues/99611), [PR #100140](https://github.com/openclaw/openclaw/pull/100140), [PR #110597](https://github.com/openclaw/openclaw/pull/110597)이 문제, 프라이버시 관문, 조건부 기본값을 직접 설명한다.

---

[← 이전: 맺음말](afterword.md) · [목차](README.md) · [다음: 출처와 재현 안내 →](13-references-reproduction-and-conclusion.md)
