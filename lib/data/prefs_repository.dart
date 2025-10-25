import 'package:shared_preferences/shared_preferences.dart';
import 'package:wave_of_habit/core/date.dart';
import 'package:wave_of_habit/feature/home/home_state.dart';

class PrefsRepository {
  static const _lastOpenDateKey = 'last_open_date';
  static String get _todayKey => 'today_${getTodayDate()}';

  PrefsRepository._();
  static final PrefsRepository _instance = PrefsRepository._();
  static PrefsRepository get instance => _instance;

  Future<TodayModel> loadTodayData() async {
    final prefs = await SharedPreferences.getInstance();
    final lastOpenDate = prefs.getString(_lastOpenDateKey);
    final today = getTodayDate();

    if (lastOpenDate != today) {
      final keys = prefs.getKeys();
      for (String key in keys) {
        if (key.startsWith('today_')) {
          await prefs.remove(key);
        }
      }
      await prefs.setString(_lastOpenDateKey, today);
      return TodayModel(date: today);
    }

    final jsonString = prefs.getString(_todayKey);
    if (jsonString != null) {
      return TodayModel.fromJson(jsonString);
    } else {
      return TodayModel(date: today);
    }
  }

  Future<void> saveTodayData(TodayModel model) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = model.toJson();
    await prefs.setString(_todayKey, jsonString);
    await prefs.setString(_lastOpenDateKey, getTodayDate());
  }
}
