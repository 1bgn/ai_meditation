import 'package:injectable/injectable.dart';
import 'package:signals/signals.dart';

import '../../domain/entities/meditation_history_item.dart';
import '../../domain/usecases/get_history.dart';

@injectable
class HistoryController {
  HistoryController(this._getHistory);

  final GetHistory _getHistory;

  final items = signal<List<MeditationHistoryItem>>([]);

  void load() => items.value = _getHistory();
}
