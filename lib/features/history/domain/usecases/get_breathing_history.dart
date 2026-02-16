import 'package:injectable/injectable.dart';
import '../entities/breathing_history_item.dart';
import '../repositories/breathing_history_repository.dart';

@injectable
class GetBreathingHistory {
  GetBreathingHistory(this._repo);
  final BreathingHistoryRepository _repo;

  List<BreathingHistoryItem> call() => _repo.getHistory();
}
