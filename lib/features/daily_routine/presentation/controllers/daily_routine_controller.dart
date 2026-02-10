import 'package:injectable/injectable.dart';
import 'package:signals/signals.dart';

import '../../../history/domain/entities/meditation_history_item.dart';
import '../../../history/domain/usecases/add_history_item.dart';
import '../../domain/entities/daily_routine_activity.dart';

@injectable
class DailyRoutineController {
  DailyRoutineController(this._addHistoryItem) {
    refreshRoutine();
  }

  final AddHistoryItem _addHistoryItem;

  final routineItems = signal<List<DailyRoutineActivity>>([]);
  final dayLabel = signal<String>('');

  static const _baseTemplates = [
    DailyRoutineMeditation(
      title: 'Morning meditation',
      description: 'Gentle focus + breath awareness',
      durationMinutes: 2,
      imageAsset: 'assets/images/morning_meditation.png',
      badgeText: 'DAY START',
      goal: 'relax',
      voiceStyle: 'soft',
      backgroundSound: 'Gentle waves',
    ),
    DailyRoutineBreathing(
      title: 'Afternoon breathing',
      description: 'Calm inhalations with steady counts',
      durationMinutes: 4,
      imageAsset: 'assets/images/daily_routine.svg',
      badgeText: 'BREATH',
      goal: 'focus',
      voiceStyle: 'neutral',
      backgroundSound: 'None',
      inhaleSeconds: 4,
      exhaleSeconds: 6,
    ),
    DailyRoutineMeditation(
      title: 'Evening relaxation',
      description: 'Slow body scan to let go',
      durationMinutes: 3,
      imageAsset: 'assets/images/evening_meditation.png',
      badgeText: 'NIGHT WIND-DOWN',
      goal: 'sleep',
      voiceStyle: 'warm',
      backgroundSound: 'Night forest',
    ),
  ];

  static const _weekdayNames = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  static const _modifiers = [
    'Calm start',
    'Focus boost',
    'Gentle wind-down',
  ];

  void refreshRoutine([DateTime? forDate]) {
    final date = forDate ?? DateTime.now();
    final variation = date.day % _baseTemplates.length;
    final dayName = _weekdayNames[date.weekday - 1];
    final items = List.generate(_baseTemplates.length, (index) {
      final template = _baseTemplates[index];
      final offset = (variation + index) % 3;
      final duration = template.durationMinutes + offset;
      final modifier = _modifiers[(variation + index) % _modifiers.length];
      if (template is DailyRoutineMeditation) {
        return DailyRoutineMeditation(
          title: template.title,
          description: '${template.description} · $modifier',
          durationMinutes: duration,
          imageAsset: template.imageAsset,
          badgeText: template.badgeText,
          goal: template.goal,
          voiceStyle: template.voiceStyle,
          backgroundSound: template.backgroundSound,
        );
      }
      final breathing = template as DailyRoutineBreathing;
      return DailyRoutineBreathing(
        title: breathing.title,
        description: '${breathing.description} · $modifier',
        durationMinutes: duration,
        imageAsset: breathing.imageAsset,
        badgeText: breathing.badgeText,
        goal: breathing.goal,
        voiceStyle: breathing.voiceStyle,
        backgroundSound: breathing.backgroundSound,
        inhaleSeconds: breathing.inhaleSeconds,
        exhaleSeconds: breathing.exhaleSeconds,
      );
    });
    routineItems.value = items;
    dayLabel.value = dayName;
  }

  Future<void> completeRoutine({DateTime? nextDay}) async {
    final items = routineItems.value;
    for (final item in items) {
      final historyItem = MeditationHistoryItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: item.title,
        durationMinutes: item.durationMinutes,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await _addHistoryItem(historyItem);
    }
    refreshRoutine(nextDay ?? DateTime.now().add(const Duration(days: 1)));
  }
}
