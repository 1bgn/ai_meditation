import 'package:injectable/injectable.dart';
import '../entities/breathing_history_item.dart';
import '../repositories/breathing_history_repository.dart';

@injectable
class AddBreathingHistoryItem {
  AddBreathingHistoryItem(this._repo);
  final BreathingHistoryRepository _repo;

  Future<void> call(BreathingHistoryItem item) => _repo.addHistoryItem(item);
}
