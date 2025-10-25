
import 'package:flutter/material.dart';
import 'package:wave_of_habit/data/prefs_repository.dart';
import 'package:wave_of_habit/feature/home/home_state.dart';

class HomeController with ChangeNotifier {
  HomeController() {
    _init();
  }

  late TodayModel _todayModel;
  TodayModel get todayModel => _todayModel;

  final _prefsRepository = PrefsRepository.instance;

  Future<void> _init() async {
    _todayModel = await _prefsRepository.loadTodayData();
    notifyListeners();
  }

  void toggleWashed() {
    _todayModel = _todayModel.copyWith(washed: !_todayModel.washed);
    _prefsRepository.saveTodayData(_todayModel);
    notifyListeners();
  }

  void togglePacked() {
    _todayModel = _todayModel.copyWith(packed: !_todayModel.packed);
    _prefsRepository.saveTodayData(_todayModel);
    notifyListeners();
  }

  void addExtraAct(String act) {
    final newActs = [..._todayModel.extraActs, act];
    _todayModel = _todayModel.copyWith(extraActs: newActs);
    _prefsRepository.saveTodayData(_todayModel);
    notifyListeners();
  }

  void removeExtraAct(String act) {
    final newActs = _todayModel.extraActs.where((e) => e != act).toList();
    _todayModel = _todayModel.copyWith(extraActs: newActs);
    _prefsRepository.saveTodayData(_todayModel);
    notifyListeners();
  }
}
