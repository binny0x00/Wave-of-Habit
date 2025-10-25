# Project PRD : “Wave of Habit”
---

## 1. 프로젝트 개요

| 항목 | 내용 |
| --- | --- |
| **프로젝트명** | “Wave of Habit” |
| **목표** | 퇴근 후 텀블러 씻기와 챙기기를 생활화하여 일회용 컵 사용을 줄이는 습관 개선 앱 |
| **핵심 컨셉** | 텀블러를 안 챙기면 방이 물에 잠기는 시각적 피드백을 통해 습관을 강화 |
| **타겟 유저** | 직장인, 환경에 관심 있는 20~30대 |
| **핵심 가치** | 지속 가능한 행동을 감정적 피드백으로 연결하는 습관 형성 앱 |

## 2. 문제 정의

- 퇴근 후 피로로 인해 텀블러를 씻지 않음 → 다음날 챙기지 않음 → 일회용 컵 사용 증가
- 환경 보호의 중요성은 알고 있지만 즉각적인 피드백이 없어 행동 지속이 어려움
- 기존 습관 앱은 목표 중심으로, 감정적 동기 부여 요소가 부족함

## 3. 해결 방안

- **요약**: 시각적 피드백을 통한 습관 강화
- **상세 내용**:
    - 사용자가 텀블러를 씻거나 챙기지 않으면 방의 물 수위가 차오름
    - 씻고 챙기면 방이 뽀송해짐
    - 추가적인 친환경 행동(대중교통, 분리수거 등)을 기록하면 더 뽀송해짐
    - 즉각적인 감정 피드백을 통해 습관 지속 유도

## 4. 핵심 기능

| 기능명 | 상세 설명 | 데이터 저장 |
| --- | --- | --- |
| **고정 습관** | 텀블러 씻기, 텀블러 챙기기 — 하루 두 가지 고정 태스크 | `SharedPreferences` |
| **추가 실천** | 오늘 실천한 친환경 행동 직접 입력 (최대 2개) | `SharedPreferences` |
| **시각 피드백** | 점수(0~4)에 따라 `AnimatedContainer` 높이가 달라지는 물 수위 | State |
| **메시지 피드백** | 점수별 문구(슬픔 → 뽀송) 표시 | - |
| **날짜 리셋** | Asia/Seoul 기준으로 날짜 비교, 하루 변경 시 초기화 | - |
| **UI 테마** | 심플한 방 + 투명한 하늘색 물 애니메이션 | - |

## 5. 점수 및 피드백 정책

| 점수 | 수위 비율 | 메시지 |
| --- | --- | --- |
| 0 | 0.7 | "지구가 조금 더 젖었어요 😢" |
| 1 | 0.4 | "아직 괜찮아요. 내일은 텀블러를 꼭!" |
| 2 | 0.2 | "좋아요! 오늘은 뽀송한 지구 🌍" |
| 3 | 0.1 | "오늘은 지구가 웃어요 ☀️" |
| 4 | 0.05 | "완벽해요! 뽀송지수 만점 ☀️" |

## 6. 사용자 흐름

1.  **앱 실행**: 오늘의 방 상태(물 수위 + 문구) 표시
2.  **체크리스트**: "텀블러 씻기" / "텀블러 챙기기" 체크
3.  **추가 실천 입력**: 오늘 실천한 행동 0~2개 입력 및 저장
4.  **점수 반영**: 물 수위 애니메이션 변경 + 문구 업데이트

## 7. 데이터 모델

- **모델명**: `TodayModel`
- **필드**:
    - `date`: String (yyyy-MM-dd)
    - `washed`: bool
    - `packed`: bool
    - `extraActs`: List<String>
- **파생 데이터**:
    - `score`: `(washed?1:0) + (packed?1:0) + extraActs.length`
    - `waterLevel`: 0.05 ~ 0.7 (점수 기반)
    - `message`: score별 문구 매핑

## 8. 저장소 스키마

- **타입**: `SharedPreferences`
- **키**:
    - `today_YYYY-MM-DD`
    - `last_open_date`
- **저장 예시**:
    ```json
    {
      "today_2025-10-25": {
        "date": "2025-10-25",
        "washed": true,
        "packed": false,
        "extra": ["대중교통 이용"]
      },
      "last_open_date": "2025-10-25"
    }
    ```

## 9. UI 레이아웃

- **AppBar**: "오늘은 텀블러 씻었나요?"
- **WaterRoom**: `AnimatedContainer` (물 수위 애니메이션)
- **ScoreBanner**: 피드백 문구 표시
- **HabitTiles**: 체크박스 2개 (씻기/챙기기)
- **TodayActionsInput**: 텍스트 입력 + 추가/삭제 버튼
- **Footer**: “내일도 뽀송하게 ☀️”

## 10. 기술 스택

- **Framework**: Flutter 3.x
- **State Management**: `setState` / `InheritedModel`
- **Storage**: `SharedPreferences`
- **UI**: Material Design 3 + `AnimatedContainer`
- **CLI Tool**: Gemini CLI + `dart mcp-server`

## 11. MVP 개발 계획 (2시간)

1.  프로젝트 세팅 및 폴더 구조
2.  `SharedPreferences` 저장소 구현
3.  모델/컨트롤러 연결
4.  WaterRoom UI + 애니메이션
5.  HabitTile + Input 위젯
6.  ScoreBanner 연결
7.  QA 및 디버그

## 12. 파일 구조

```
lib/
├── main.dart
├── app.dart
├── constants.dart
├── core/
│   └── date.dart
├── data/
│   └── prefs_repository.dart
└── feature/
    └── home/
        ├── home_page.dart
        ├── home_state.dart
        ├── home_controller.dart
        └── widgets/
            ├── water_room.dart
            ├── habit_tile.dart
            ├── todays_actions_input.dart
            └── score_banner.dart
```

## 13. 성공 지표 (KPI)

| 지표 | 목표 |
| --- | --- |
| **Daily Active Rate** | 60% |
| **7-day Retention** | 40% |
| **Positive Emotion Index** | 70% |

## 14. 향후 확장 계획

- 주간 통계 그래프 (습관 유지율)
- 방 커스터마이징 (식물, 조명, 벽 색상)
- 로컬 알림: 퇴근 시간대 씻기 알림
- 친구와 비교하기 (습관 랭킹)

## 15. 인용문

> 습관의 파도가 방을 물들이기 전에, 오늘 하나의 테스크를 수행하자!
