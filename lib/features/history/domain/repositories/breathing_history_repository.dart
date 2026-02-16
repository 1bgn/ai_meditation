import '../entities/breathing_history_item.dart';

abstract class BreathingHistoryRepository {
  List<BreathingHistoryItem> getHistory();
  Future<void> addHistoryItem(BreathingHistoryItem item);
  Future<void> deleteHistoryItem(BreathingHistoryItem item);
}
