import '../entities/meditation_history_item.dart';

abstract class HistoryRepository {
  List<MeditationHistoryItem> getHistory();
  Future<void> addHistoryItem(MeditationHistoryItem item);
}
