import 'package:injectable/injectable.dart';

import '../entities/meditation_history_item.dart';
import '../repositories/history_repository.dart';

@injectable
class DeleteHistoryItem {
  DeleteHistoryItem(this._repo);
  final HistoryRepository _repo;

  Future<void> call(MeditationHistoryItem item) => _repo.deleteHistoryItem(item);
}
