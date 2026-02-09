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

  bool getOnboardingCompleted() =>
      _prefs.getBool(_keyOnboardingCompleted) ?? false;

  Future<void> setOnboardingCompleted(bool value) =>
      _prefs.setBool(_keyOnboardingCompleted, value);

  String? getLastMeditationTitle() =>
      _prefs.getString(_keyLastMeditationTitle);

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

  Future<void> setMeditationHistoryRaw(
    List<Map<String, dynamic>> items,
  ) =>
      _prefs.setString(_keyMeditationHistory, jsonEncode(items));
}
