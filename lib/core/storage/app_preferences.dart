import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class AppPreferences {
  AppPreferences(this._prefs);

  final SharedPreferences _prefs;

  static const _keyOnboardingCompleted = 'onboarding_completed';
  static const _keyLastMeditationTitle = 'last_meditation_title';
  static const _keyMeditationHistory = 'meditation_history';
  static const _keyBreathingHistory = 'breathing_history';

  List<Map<String, dynamic>> getBreathingHistoryRaw() {
    final raw = _prefs.getString(_keyBreathingHistory);
    if (raw == null || raw.isEmpty) return [];

    final decoded = jsonDecode(raw);
    if (decoded is List) {
      // безопаснее, чем cast<Map<String,dynamic>>() напрямую
      return decoded
          .whereType<Map>()
          .map((m) => m.cast<String, dynamic>())
          .toList();
    }
    return [];
  }

  Future<void> setBreathingHistoryRaw(List<Map<String, dynamic>> items) =>
      _prefs.setString(_keyBreathingHistory, jsonEncode(items));
  static const _keyRoutineSavedPrefix = 'routine_saved_'; // + YYYY-MM-DD

  String _routineSavedKey(DateTime d) => '$_keyRoutineSavedPrefix${_dayKey(d)}';

  bool getRoutineSaved(DateTime date) =>
      _prefs.getBool(_routineSavedKey(date)) ?? false;

  Future<void> setRoutineSaved(DateTime date, bool value) =>
      _prefs.setBool(_routineSavedKey(date), value);
  // Daily routine progress
  static const _keyRoutineNextIndexPrefix =
      'routine_next_index_'; // + YYYY-MM-DD
  static const _keyRoutineOpenedPrefix =
      'routine_opened_'; // + YYYY-MM-DD (stringList of json)

  bool getOnboardingCompleted() =>
      _prefs.getBool(_keyOnboardingCompleted) ?? false;

  Future<void> setOnboardingCompleted(bool value) =>
      _prefs.setBool(_keyOnboardingCompleted, value);

  String? getLastMeditationTitle() => _prefs.getString(_keyLastMeditationTitle);

  Future<void> setLastMeditationTitle(String value) =>
      _prefs.setString(_keyLastMeditationTitle, value);

  List<Map<String, dynamic>> getMeditationHistoryRaw() {
    final raw = _prefs.getString(_keyMeditationHistory);
    if (raw == null || raw.isEmpty) {
      return [];
    }
    final decoded = jsonDecode(raw);
    if (decoded is List) {
      return decoded.cast<Map<String, dynamic>>();
    }
    return [];
  }

  Future<void> setMeditationHistoryRaw(List<Map<String, dynamic>> items) =>
      _prefs.setString(_keyMeditationHistory, jsonEncode(items));

  // -------- Routine helpers --------

  String _dayKey(DateTime d) {
    final y = d.year.toString().padLeft(4, '0');
    final m = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    return '$y-$m-$day';
  }

  String _routineNextIndexKey(DateTime d) =>
      '$_keyRoutineNextIndexPrefix${_dayKey(d)}';

  String _routineOpenedKey(DateTime d) =>
      '$_keyRoutineOpenedPrefix${_dayKey(d)}';

  int getRoutineNextIndex(DateTime date) =>
      _prefs.getInt(_routineNextIndexKey(date)) ?? 0;

  Future<void> setRoutineNextIndex(DateTime date, int value) =>
      _prefs.setInt(_routineNextIndexKey(date), value);

  Future<void> resetRoutineProgress(DateTime date) async {
    await setRoutineNextIndex(date, 0);
    await _prefs.remove(_routineOpenedKey(date));
  }

  Future<void> addRoutineOpened(
    DateTime date,
    Map<String, dynamic> entry,
  ) async {
    final key = _routineOpenedKey(date);
    final list = List<String>.from(_prefs.getStringList(key) ?? const []);
    list.add(jsonEncode(entry));
    await _prefs.setStringList(key, list);
  }

  List<Map<String, dynamic>> getRoutineOpenedRaw(DateTime date) {
    final key = _routineOpenedKey(date);
    final list = _prefs.getStringList(key) ?? const [];
    return list
        .map((s) {
          final decoded = jsonDecode(s);
          if (decoded is Map) return decoded.cast<String, dynamic>();
          return <String, dynamic>{};
        })
        .where((m) => m.isNotEmpty)
        .toList();
  }
}
