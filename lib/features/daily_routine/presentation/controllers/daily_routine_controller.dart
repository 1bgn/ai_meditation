import 'dart:math';

import 'package:injectable/injectable.dart';
import 'package:signals/signals.dart';

import '../../../history/domain/entities/meditation_history_item.dart';
import '../../../history/domain/usecases/add_history_item.dart';
import '../../domain/entities/daily_routine_item.dart';

@injectable
class DailyRoutineController {
  DailyRoutineController(this._addHistoryItem);

  final AddHistoryItem _addHistoryItem;

  final currentRoutine = signal<DailyRoutineItem?>(null);

  final routines = [
    const DailyRoutineItem(
      title: 'Morning Reset',
      description: 'Breathing + focus meditation',
      durationMinutes: 8,
    ),
    const DailyRoutineItem(
      title: 'Midday Pause',
      description: 'Quick body scan for clarity',
      durationMinutes: 6,
    ),
    const DailyRoutineItem(
      title: 'Evening Wind-Down',
      description: 'Relaxation to end the day',
      durationMinutes: 10,
    ),
    const DailyRoutineItem(
      title: 'Creative Boost',
      description: 'Breathing + visualization',
      durationMinutes: 7,
    ),
  ];

  Future<void> generate() async {
    final next = routines[Random().nextInt(routines.length)];
    currentRoutine.value = next;
    final historyItem = MeditationHistoryItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: next.title,
      durationMinutes: next.durationMinutes,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    await _addHistoryItem(historyItem);
  }
}
