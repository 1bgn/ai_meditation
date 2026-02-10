import 'package:injectable/injectable.dart';

import '../../../history/domain/entities/meditation_history_item.dart';
import '../../../history/domain/usecases/add_history_item.dart';
import '../../domain/entities/daily_routine_item.dart';

@injectable
class DailyRoutineController {
  DailyRoutineController(this._addHistoryItem);

  final AddHistoryItem _addHistoryItem;

  final routineItems = const [
    DailyRoutineItem(
      title: 'Morning Meditation',
      description: 'Gentle focus + breath awareness',
      durationMinutes: 2,
    ),
    DailyRoutineItem(
      title: 'Afternoon breathing',
      description: 'Inhale 4 sec • Exhale 6 sec',
      durationMinutes: 5,
    ),
    DailyRoutineItem(
      title: 'Evening Relaxation',
      description: 'Slow body scan to let go',
      durationMinutes: 3,
    ),
  ];

  Future<void> completeRoutine() async {
    for (final item in routineItems) {
      final historyItem = MeditationHistoryItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: item.title,
        durationMinutes: item.durationMinutes,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await _addHistoryItem(historyItem);
    }
  }
}
