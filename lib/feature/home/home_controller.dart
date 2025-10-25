
import 'package:wave_of_habit/data/prefs_repository.dart';
import 'package:wave_of_habit/feature/home/home_state.dart';

class HomeController {
  HomeController({
    required this.onStateChanged,
  });

  final VoidCallback onStateChanged;

  late TodayModel _todayModel;
  TodayModel get todayModel => _todayModel;

  final _prefsRepository = PrefsRepository.instance;

  Future<void> loadTodayData() async {
    _todayModel = await _prefsRepository.loadTodayData();
    onStateChanged();
  }

  void toggleWashed(bool value) {
    _todayModel = _todayModel.copyWith(washed: value);
    _prefsRepository.saveTodayData(_todayModel);
    onStateChanged();
  }

  void togglePacked(bool value) {
    _todayModel = _todayModel.copyWith(packed: value);
    _prefsRepository.saveTodayData(_todayModel);
    onStateChanged();
  }

  void addExtraAct(String act) {
    final newActs = [..._todayModel.extraActs, act];
    _todayModel = _todayModel.copyWith(extraActs: newActs);
    _prefsRepository.saveTodayData(_todayModel);
    onStateChanged();
  }

  void removeExtraAct(String act) {
    final newActs = _todayModel.extraActs.where((e) => e != act).toList();
    _todayModel = _todayModel.copyWith(extraActs: newActs);
    _prefsRepository.saveTodayData(_todayModel);
    onStateChanged();
  }
}
