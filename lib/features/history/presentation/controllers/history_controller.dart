import 'package:injectable/injectable.dart';
import 'package:signals/signals.dart';

import '../../domain/entities/meditation_history_item.dart';
import '../../domain/usecases/add_history_item.dart';
import '../../domain/usecases/delete_history_item.dart';
import '../../domain/usecases/get_history.dart';

@LazySingleton()
class HistoryController {
  HistoryController(this._getHistory, this._deleteHistoryItem, this._addHistoryItem);

  final AddHistoryItem _addHistoryItem;
  final GetHistory _getHistory;
  final DeleteHistoryItem _deleteHistoryItem;

  final items = signal<List<MeditationHistoryItem>>([]);

  Future<void> add(MeditationHistoryItem item) async {
    items.value = [item, ...items.value];
    await _addHistoryItem(item);
  }

  void load() => items.value = _getHistory();

  Future<void> delete(MeditationHistoryItem item) async {
    items.value = items.value.where((e) => e.createdAt != item.createdAt).toList();
    await _deleteHistoryItem(item);
  }
}
