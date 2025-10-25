# Wave-of-Habit
FLUTTER KOREA 2025 Vibe Coding Hackathons 레퍼지토리입니다.

##########

🌊 Wave of Habit — 습관의 파도

안녕하세요, 저희 프로젝트 Wave of Habit은
“퇴근 후 텀블러를 씻는 습관”을 자연스럽게 만들기 위한 앱입니다.

회사에서 하루를 마치고 돌아오면 피곤해서 텀블러를 씻지 않게 되고,
결국 다음날 일회용 컵을 쓰게 되는 경우 많죠.
이런 작은 반복이 쌓여 환경에 큰 영향을 미치지만,
그 변화를 체감하기는 어렵습니다.

그래서 저희는 감정적인 시각 피드백으로 이 문제를 풀었습니다.
바로, “나의 방이 물에 잠긴다”는 콘셉트예요.
텀블러를 씻지 않거나 챙기지 않으면
앱 속 방에 물이 점점 차오르고,
반대로 실천하면 다시 뽀송하게 변합니다.

앱의 기능은 단순합니다.
첫째, 매일 ‘텀블러 씻기’와 ‘챙기기’ 두 가지 고정 습관을 체크하고,
둘째, 추가로 내가 실천한 친환경 행동을 기록할 수 있습니다.
이 점수를 바탕으로 방의 물 수위가 애니메이션으로 변화하고,
그에 맞춰 “지구가 조금 젖었어요” 같은 감정 피드백이 표시됩니다.

이 앱은 단순한 체크리스트가 아니라,
내 행동이 세상에 어떤 파동을 만드는지 감정적으로 체험하게 하는 도구입니다.
Wave of Habit, 작은 습관이 만들어내는 변화를 시각화하다 —
감사합니다. 🌍💧

##########

🌊 프로젝트 개요 - Wave of Habit
1. 프로젝트 개요
항목	내용
프로젝트명	Wave of Habit
목표	퇴근 후 텀블러 씻기와 챙기기를 생활화하여 일회용 컵 사용 감소 유도
핵심 컨셉	텀블러를 안 챙기면 방이 물에 잠기는 시각 피드백으로 습관 강화
타깃 유저	직장인, 환경에 관심 있는 20–30대
핵심 가치	🌎 습관 개선을 ‘지속 가능한 행동’으로 연결하는 감정형 피드백 앱

2. 문제 정의 (Problem)

퇴근 후 피로로 인해 텀블러를 씻지 않음 → 다음날 챙기지 않음 → 일회용 컵 사용 증가

환경 보호의 중요성은 알고 있으나, 즉각적인 피드백 부재로 행동이 지속되지 않음

습관 앱은 많지만 대부분 ‘목표 관리’ 중심이며, 감정적 동기 부여 요소가 부족함.

3. 솔루션 (Solution)

시각적 피드백 기반 습관 강화 앱

사용자의 행동(씻기/챙기기/추가 실천)에 따라 방의 물 수위가 변화

행동을 하지 않으면 물이 차오르고, 하면 방이 뽀송해짐
→ **나비효과(환경 변화)**를 시각적으로 체험

- 시연 영상
  https://drive.google.com/drive/folders/1q8FdmFKktJHM-_MO1FuLALbnH-YolGRp?usp=sharing

<img src="https://github.com/user-attachments/assets/2679e304-bbe7-464c-8d68-a2e6c48474b7" alt="wave-of-habit-demo" width="300"/>

4. 핵심 기능 (Features)
분류	기능명	상세 설명	상태 저장
✅ 고정 습관	텀블러 씻기, 텀블러 챙기기	하루 2개 고정 태스크. 토글 체크 가능	SharedPreferences
➕ 추가 실천	오늘 실천한 친환경 행동 추가	직접 입력 (최대 2개) / 삭제 가능	SharedPreferences
💧 시각 피드백	방의 물 수위 변화	점수(0~4)에 따라 수위 애니메이션	로컬 상태
💬 메시지 피드백	피드백 문구 표시	점수별 감정 문구 (슬픔 → 보송)	즉시 반영
🕓 날짜 리셋	하루가 바뀌면 초기화	Asia/Seoul 기준 yyyy-MM-dd 비교	SharedPreferences
🎨 UI 테마	방 + 물 애니메이션	투명 하늘색 AnimatedContainer	-

5. 점수 규칙 & 피드백 매핑
점수	조건	수위 비율	문구
0	아무것도 안 함	0.7	“지구가 조금 더 젖었어요 😢”
1	씻기 or 챙기기 중 1개	0.4	“아직 괜찮아요. 내일은 텀블러를 꼭!”
2	둘 다 or 추가 실천 1개 포함	0.2	“좋아요! 오늘은 뽀송한 지구 🌍”
3	세 가지 이상 실천	0.1	“오늘은 지구가 웃어요 ☀️”
4	만점(씻기+챙기기+2실천)	0.05	“완벽해요! 뽀송지수 만점 ☀️”

## Troubleshooting/Issues Encountered

### 1. `_todayModel` not initialized in `HomeController`

**Problem:** The `_todayModel` field in `HomeController` was declared as `late` but was not initialized in the constructor. This could lead to a runtime error if `_todayModel` was accessed before `loadTodayData()` completed.

**Solution:** Initialized `_todayModel` with a default `TodayModel(date: '')` in the `HomeController`'s constructor. Also, made `loadTodayData()` private and called it from the constructor to ensure proper initialization.

### 2. `VoidCallback` not recognized in `home_controller.dart`

**Problem:** The `VoidCallback` type was not recognized in `home_controller.dart`, resulting in a compilation error.

**Solution:** Added `import 'package:flutter/foundation.dart';` to `home_controller.dart` to correctly import the `VoidCallback` definition.
