import 'dart:math';

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
    'Reset your mind',
    'Slow and steady',
  ];

  // Presets (как ты перечислил)
  static const _goals = ['Calm', 'Neutral', 'Stressed', 'Anxious'];
  static const _voices = ['Soft', 'Neutral', 'Deep', 'Warm'];
  static const _backgroundSounds = ['nature', 'ambient music', 'rain', 'none'];

  // Для breathing используем те же значения, чтобы их можно было переиспользовать в GenerationPage
  static const _breathingMoods = _goals;

  int _seedFromDate(DateTime d) => d.year * 10000 + d.month * 100 + d.day;

  T _pick<T>(Random rng, List<T> items) => items[rng.nextInt(items.length)];

  int _clampDuration(int minutes) => minutes < 1 ? 1 : minutes;

  ({int inhale, int exhale}) _patternForMood(String mood) {
    switch (mood) {
      case 'Calm':
        return (inhale: 4, exhale: 6);

      case 'Neutral':
        return (inhale: 4, exhale: 4);

      case 'Stressed':
        // "прячем" hold внутри inhale/exhale блоков (UI не меняем)
        return (inhale: 8, exhale: 8);

      case 'Anxious':
        // 4-7-8: inhale(4)+hold(7)=11, exhale(8)
        return (inhale: 11, exhale: 8);

      default:
        return (inhale: 4, exhale: 4);
    }
  }

  void refreshRoutine([DateTime? forDate, bool reshuffle = false]) {
    final date = forDate ?? DateTime.now();
    final dayName = _weekdayNames[date.weekday - 1];

    // По умолчанию рутина стабильна для текущего дня.
    // Если reshuffle=true — можно перегенерить новую “случайную” прямо сейчас.
    final baseSeed = _seedFromDate(date);
    final seed = reshuffle
        ? (baseSeed ^ DateTime.now().millisecondsSinceEpoch)
        : baseSeed;
    final rng = Random(seed);

    final morningDuration = _clampDuration(2 + rng.nextInt(3)); // 2..4
    final afternoonDuration = _clampDuration(3 + rng.nextInt(4)); // 3..6
    final eveningDuration = _clampDuration(2 + rng.nextInt(4)); // 2..5

    final morningDescBase = _pick(rng, const [
      'Gentle focus + breath awareness',
      'Start slow and set intention',
      'Light grounding and presence',
    ]);

    final eveningDescBase = _pick(rng, const [
      'Slow body scan to let go',
      'Ease tension and unwind',
      'Quiet reflection before rest',
    ]);

    // Breathing mood/pattern
    final breathingMood = _pick(rng, _breathingMoods);
    final breathingPattern = _patternForMood(breathingMood);

    final modifier1 = _pick(rng, _modifiers);
    final modifier2 = _pick(rng, _modifiers);
    final modifier3 = _pick(rng, _modifiers);

    // Meditation presets (Goals/Voices/Background Sound)
    final morningGoal = _pick(rng, _goals);
    final morningVoice = _pick(rng, _voices);
    final morningSound = _pick(rng, _backgroundSounds);

    final afternoonGoal = _pick(rng, _goals);
    final afternoonVoice = _pick(rng, _voices);
    final afternoonSound = _pick(rng, _backgroundSounds);

    final eveningGoal = _pick(rng, _goals);
    final eveningVoice = _pick(rng, _voices);
    final eveningSound = _pick(rng, _backgroundSounds);

    final items = <DailyRoutineActivity>[
      DailyRoutineMeditation(
        title: 'Morning meditation',
        description: '$morningDescBase · $modifier1',
        durationMinutes: morningDuration,
        imageAsset: 'assets/images/morning_meditation.png',
        badgeText: 'DAY START',
        goal: morningGoal,
        voiceStyle: morningVoice,
        backgroundSound: morningSound,
      ),
      DailyRoutineBreathing(
        title: 'Afternoon breathing',
        description:
            '${_pick(rng, const ['Calm inhalations with steady counts', 'Reset with paced breathing', 'Slow breath to regain control'])} · $modifier2',
        durationMinutes: afternoonDuration,
        imageAsset: 'assets/images/daily_routine.svg',
        // badgeText используем как mood (ты дальше его прокидываешь в updateMood)
        badgeText: breathingMood,
        goal: afternoonGoal,
        voiceStyle: afternoonVoice,
        backgroundSound: afternoonSound,
        inhaleSeconds: breathingPattern.inhale,
        exhaleSeconds: breathingPattern.exhale,
      ),
      DailyRoutineMeditation(
        title: 'Evening relaxation',
        description: '$eveningDescBase · $modifier3',
        durationMinutes: eveningDuration,
        imageAsset: 'assets/images/evening_meditation.png',
        badgeText: 'NIGHT WIND-DOWN',
        goal: eveningGoal,
        voiceStyle: eveningVoice,
        backgroundSound: eveningSound,
      ),
    ];

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
