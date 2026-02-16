import 'package:injectable/injectable.dart';

import '../../../../core/storage/app_preferences.dart';
import '../../domain/entities/meditation_history_item.dart';

@lazySingleton
class HistoryLocalDatasource {
  HistoryLocalDatasource(this._preferences);

  final AppPreferences _preferences;

  List<MeditationHistoryItem> getHistory() => _preferences
      .getMeditationHistoryRaw()
      .map(MeditationHistoryItem.fromJson)
      .toList();

  Future<void> addHistoryItem(MeditationHistoryItem item) async {
    final items = getHistory()..insert(0, item);
    await _preferences.setMeditationHistoryRaw(items.map((e) => e.toJson()).toList());
    await _preferences.setLastMeditationTitle(item.title);
  }

  Future<void> deleteHistoryItem(MeditationHistoryItem item) async {
    final items = getHistory()
      ..removeWhere((e) => e.createdAt == item.createdAt); // или e.id == item.id
    await _preferences.setMeditationHistoryRaw(items.map((e) => e.toJson()).toList());
  }
}
