# 🌊 Wave of Habit: 개발 계획 (PLAN.md)

이 문서는 `README.md`와 `PRD.md`를 기반으로 "Wave of Habit" 앱의 구체적인 개발 계획을 정의합니다.

---

### 1. 프로젝트 아키텍처

본 프로젝트는 Flutter의 특성을 살려 단순하고 확장 가능성이 있는 **피처(Feature) 중심 아키텍처**를 채택합니다.

- **`lib/`**: 소스 코드의 루트 디렉토리입니다.
- **`lib/main.dart`**: 앱의 진입점으로, `App` 위젯을 실행합니다.
- **`lib/app.dart`**: 앱의 최상위 위젯으로, 테마, 라우팅 등 전역 설정을 관리합니다.
- **`lib/data/`**: 데이터 소스를 관리합니다. `SharedPreferences`를 사용하는 `PrefsRepository`가 위치합니다.
- **`lib/core/`**: 날짜 처리 등 앱 전반에서 사용되는 핵심 로직을 포함합니다.
- **`lib/feature/`**: 각 기능별 UI와 상태 로직을 그룹화합니다. 현재는 `home` 피처만 존재합니다.
- **`lib/feature/home/`**: 앱의 핵심 기능인 홈 화면 관련 코드를 모두 포함합니다.
    - `home_page.dart`: 홈 화면의 UI 레이아웃을 구성합니다.
    - `home_state.dart`: 홈 화면의 상태(데이터 모델)를 정의합니다.
    - `home_controller.dart`: 상태 변경 로직과 비즈니스 로직을 처리합니다.
    - `widgets/`: 홈 화면에서 사용하는 재사용 가능한 위젯들을 관리합니다.
- **`lib/constants.dart`**: 앱에서 사용되는 상수(예: 점수, 메시지)를 관리합니다.

### 2. 데이터 모델 설계

PRD에 명시된 `TodayModel`을 기반으로 상태를 설계합니다.

- **`TodayModel` (`home_state.dart`)**: UI에 필요한 모든 데이터를 포함하는 불변(immutable) 객체입니다.

```dart
class TodayModel {
  final String date;      // "yyyy-MM-dd" 형식의 날짜
  final bool washed;      // 텀블러 씻기 여부
  final bool packed;      // 텀블러 챙기기 여부
  final List<String> extraActs; // 추가 실천 항목

  // 파생 데이터 (Derived Data)
  final int score;        // 행동 점수 (0-4)
  final double waterLevel;  // 물 수위 (0.05-0.7)
  final String message;     // 피드백 메시지

  // 생성자 및 fromJson/toJson 팩토리 메서드 포함
}
```

- **데이터 흐름**:
    1. `PrefsRepository`가 `SharedPreferences`에서 JSON 형태의 데이터를 읽습니다.
    2. `TodayModel.fromJson`을 통해 모델 객체를 생성합니다.
    3. `HomeController`가 이 모델을 상태로 관리하며, 사용자 액션에 따라 새 모델을 생성하여 상태를 업데이트합니다.

### 3. 상태 관리 전략

앱의 규모가 작고 단일 화면 중심이므로, 외부 라이브러리 없이 Flutter의 내장 기능을 최대한 활용합니다.

- **`setState`**: `HomePage`와 같은 최상위 위젯에서 `HomeController`를 통해 상태가 업데이트될 때 UI를 다시 그리게 하는 기본 메커니즘으로 사용됩니다.
- **`InheritedModel`**: `TodayModel`의 특정 필드가 변경될 때만 해당 데이터를 사용하는 위젯만 리빌드되도록 하여 불필요한 UI 렌더링을 방지합니다.
    - 예를 들어, `score`가 변경되면 `ScoreBanner`와 `WaterRoom`만 리빌드되고, `extraActs`가 변경되면 `TodayActionsInput` 위젯만 리빌드되도록 구현합니다.
    - 이를 통해 `setState`의 단점을 보완하고 성능을 최적화합니다.

### 4. 로컬 저장소 구현 방법

`shared_preferences` 패키지를 사용하여 간단한 Key-Value 형태로 데이터를 저장합니다.

- **`PrefsRepository` (`data/prefs_repository.dart`)**:
    - `SharedPreferences`의 모든 접근 로직을 캡슐화하는 싱글톤 클래스입니다.
    - **`Future<TodayModel> loadTodayData()`**:
        - `last_open_date`를 확인하여 오늘 날짜와 다르면 데이터를 리셋합니다.
        - `today_YYYY-MM-DD` 키로 저장된 JSON 문자열을 읽어 `TodayModel`로 변환하여 반환합니다.
    - **`Future<void> saveTodayData(TodayModel model)`**:
        - `TodayModel` 객체를 JSON 문자열로 변환하여 `today_YYYY-MM-DD` 키로 저장합니다.
        - `last_open_date`를 오늘 날짜로 업데이트합니다.

### 5. UI 화면 구성

PRD의 UI 레이아웃을 기반으로 위젯 트리를 구성합니다.

- **`HomePage`**:
    - `Scaffold`
        - `AppBar` (제목 표시)
        - `Column`
            - `Expanded`
                - `Stack`
                    - `WaterRoom` (배경, 물 애니메이션)
                    - `ScoreBanner` (점수 및 메시지 표시)
            - `HabitTiles` (고정 습관 체크박스)
            - `TodayActionsInput` (추가 실천 입력/표시)
            - `Footer` (격려 문구)

### 6. 구현 순서 (우선순위별)

MVP 개발 계획을 구체화한 단계별 구현 순서입니다.

1.  **1단계: 프로젝트 설정 및 코어 로직 (30분)**
    - Flutter 프로젝트 생성 (`flutter create`)
    - `shared_preferences` 의존성 추가 (`pubspec.yaml`)
    - `core/date.dart`: 날짜 비교 유틸리티 함수 구현
    - `constants.dart`: 점수, 메시지 등 상수 정의

2.  **2단계: 데이터 계층 구현 (30분)**
    - `feature/home/home_state.dart`: `TodayModel` 클래스 정의 (`fromJson`, `toJson` 포함)
    - `data/prefs_repository.dart`: `SharedPreferences`를 사용하는 저장소 클래스 구현 (load, save, reset 로직)

3.  **3단계: 상태 및 비즈니스 로직 구현 (20분)**
    - `feature/home/home_controller.dart`: `TodayModel`을 상태로 관리하고, `PrefsRepository`와 상호작용하며 점수 계산 등 비즈니스 로직을 처리하는 컨트롤러 구현

4.  **4단계: 기본 UI 레이아웃 및 위젯 구현 (40분)**
    - `feature/home/home_page.dart`: `InheritedModel`과 `HomeController`를 사용하여 기본 화면 구조 빌드
    - `widgets/`: `WaterRoom`, `ScoreBanner`, `HabitTile`, `TodayActionsInput` 등 각 UI 컴포넌트를 정적(static)인 형태로 구현

5.  **5단계: UI와 상태 연결 및 동적 기능 구현 (50분)**
    - `HabitTile`의 체크박스, `TodayActionsInput`의 입력/삭제 버튼 이벤트를 `HomeController`의 메서드와 연결
    - `HomeController`의 상태 변경에 따라 `WaterRoom`의 `AnimatedContainer`가 작동하도록 구현
    - `ScoreBanner`의 메시지가 실시간으로 업데이트되도록 연결
    - 앱 실행 시 날짜를 비교하여 데이터를 초기화하는 로직 연동

6.  **6단계: 최종 QA 및 디버깅 (10분)**
    - 전체 기능 테스트 (체크, 입력, 삭제, 날짜 변경)
    - UI/UX 최종 다듬기 및 버그 수정
