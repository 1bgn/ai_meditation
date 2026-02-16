import 'package:injectable/injectable.dart';

import '../../../../core/storage/app_preferences.dart';
import '../../domain/entities/breathing_history_item.dart';

@lazySingleton
class BreathingHistoryLocalDatasource {
  BreathingHistoryLocalDatasource(this._preferences);
  final AppPreferences _preferences;

  List<BreathingHistoryItem> getHistory() => _preferences
      .getBreathingHistoryRaw()
      .map(BreathingHistoryItem.fromJson)
      .toList();

  Future<void> addHistoryItem(BreathingHistoryItem item) async {
    final items = getHistory()..insert(0, item);
    await _preferences.setBreathingHistoryRaw(
      items.map((e) => e.toJson()).toList(),
    );
  }

  Future<void> deleteHistoryItem(BreathingHistoryItem item) async {
    final items = getHistory()..removeWhere((e) => e.id == item.id);
    await _preferences.setBreathingHistoryRaw(
      items.map((e) => e.toJson()).toList(),
    );
  }
}
