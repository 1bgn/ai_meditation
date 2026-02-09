import 'package:injectable/injectable.dart';

import '../entities/meditation_history_item.dart';
import '../repositories/history_repository.dart';

@injectable
class AddHistoryItem {
  const AddHistoryItem(this._repository);

  final HistoryRepository _repository;

  Future<void> call(MeditationHistoryItem item) =>
      _repository.addHistoryItem(item);
}
