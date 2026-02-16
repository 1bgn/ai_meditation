import 'package:injectable/injectable.dart';
import 'package:signals/signals.dart';

import '../../domain/entities/breathing_history_item.dart';
import '../../domain/usecases/add_breathing_history_item.dart';
import '../../domain/usecases/get_breathing_history.dart';

@injectable
class BreathingHistoryController {
  BreathingHistoryController(this._getHistory, this._addHistoryItem);

  final GetBreathingHistory _getHistory;
  final AddBreathingHistoryItem _addHistoryItem;

  final items = signal<List<BreathingHistoryItem>>([]);

  void load() => items.value = _getHistory();

  Future<void> add(BreathingHistoryItem item) async {
    items.value = [item, ...items.value];
    await _addHistoryItem(item);
  }
}
