# ✅ Wave of Habit: 작업 체크리스트 (TASKS.md)

`PLAN.md`에 정의된 개발 계획에 따른 작업 목록입니다.

**상태 표시:**
- `[ ]`: 미완료 (Not Started)
- `[~]`: 진행 중 (In Progress)
- `[x]`: 완료 (Completed)

---

### 1단계: 프로젝트 설정 및 코어 로직

- [x] Flutter 프로젝트 생성 (`flutter create`)
- [x] `shared_preferences` 의존성 추가 (`pubspec.yaml`)
- [x] `core/date.dart`: 날짜 비교 유틸리티 함수 구현
- [x] `constants.dart`: 점수, 메시지 등 상수 정의

### 2단계: 데이터 계층 구현

- [ ] `feature/home/home_state.dart`: `TodayModel` 클래스 정의 (`fromJson`, `toJson` 포함)
- [ ] `data/prefs_repository.dart`: `SharedPreferences`를 사용하는 저장소 클래스 구현 (load, save, reset 로직)

### 3단계: 상태 및 비즈니스 로직 구현

- [ ] `feature/home/home_controller.dart`: `TodayModel`을 상태로 관리하고, `PrefsRepository`와 상호작용하며 점수 계산 등 비즈니스 로직을 처리하는 컨트롤러 구현

### 4단계: 기본 UI 레이아웃 및 위젯 구현

- [ ] `feature/home/home_page.dart`: `InheritedModel`과 `HomeController`를 사용하여 기본 화면 구조 빌드
- [ ] `widgets/`: `WaterRoom`, `ScoreBanner`, `HabitTile`, `TodayActionsInput` 등 각 UI 컴포넌트를 정적(static)인 형태로 구현

### 5단계: UI와 상태 연결 및 동적 기능 구현

- [ ] `HabitTile`의 체크박스, `TodayActionsInput`의 입력/삭제 버튼 이벤트를 `HomeController`의 메서드와 연결
- [ ] `HomeController`의 상태 변경에 따라 `WaterRoom`의 `AnimatedContainer`가 작동하도록 구현
- [ ] `ScoreBanner`의 메시지가 실시간으로 업데이트되도록 연결
- [ ] 앱 실행 시 날짜를 비교하여 데이터를 초기화하는 로직 연동

### 6단계: 최종 QA 및 디버깅

- [ ] 전체 기능 테스트 (체크, 입력, 삭제, 날짜 변경)
- [ ] UI/UX 최종 다듬기 및 버그 수정
