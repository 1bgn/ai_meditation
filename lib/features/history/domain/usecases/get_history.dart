import 'package:injectable/injectable.dart';

import '../entities/meditation_history_item.dart';
import '../repositories/history_repository.dart';

@injectable
class GetHistory {
  const GetHistory(this._repository);

  final HistoryRepository _repository;

  List<MeditationHistoryItem> call() => _repository.getHistory();
}
