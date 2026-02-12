import 'dart:async';
import 'dart:math';

import 'package:ai_meditation/core/storage/app_preferences.dart';
import 'package:injectable/injectable.dart';
import 'package:signals/signals.dart';

import '../../../history/domain/entities/meditation_history_item.dart';
import '../../../history/domain/usecases/add_history_item.dart';
import '../../domain/entities/daily_routine_activity.dart';

@injectable
class DailyRoutineController {
  DailyRoutineController(this._addHistoryItem, this._prefs) {
    refreshRoutine();
  }

  final AddHistoryItem _addHistoryItem;
  final AppPreferences _prefs;

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

  // Presets
  static const _goals = ['Calm', 'Neutral', 'Stressed', 'Anxious'];
  static const _voices = ['Soft', 'Neutral', 'Deep', 'Warm'];
  static const _backgroundSounds = ['nature', 'ambient music', 'rain', 'none'];

  static const _breathingMoods = _goals;
  Future<bool> saveAllItemsToHistory({DateTime? forDate}) async {
    final date = forDate ?? DateTime.now();

    // защита от повторного сохранения
    if (_prefs.getRoutineSaved(date)) return false;

    final items = routineItems.value;
    if (items.isEmpty) return false;

    for (final item in items) {
      final historyItem = MeditationHistoryItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: item.title,
        durationMinutes: item.durationMinutes,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await _addHistoryItem.call(historyItem);
    }

    await _prefs.setRoutineSaved(date, true);
    return true;
  }

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
        return (inhale: 8, exhale: 8);
      case 'Anxious':
        return (inhale: 11, exhale: 8);
      default:
        return (inhale: 4, exhale: 4);
    }
  }

  void refreshRoutine([DateTime? forDate, bool reshuffle = false]) {
    final date = forDate ?? DateTime.now();
    final dayName = _weekdayNames[date.weekday - 1];

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

    final breathingMood = _pick(rng, _breathingMoods);
    final breathingPattern = _patternForMood(breathingMood);

    final modifier1 = _pick(rng, _modifiers);
    final modifier2 = _pick(rng, _modifiers);
    final modifier3 = _pick(rng, _modifiers);

    final items = <DailyRoutineActivity>[
      DailyRoutineMeditation(
        title: 'Morning meditation',
        description: '$morningDescBase · $modifier1',
        durationMinutes: morningDuration,
        imageAsset: 'assets/images/morning_meditation.png',
        badgeText: 'DAY START',
        goal: _pick(rng, _goals),
        voiceStyle: _pick(rng, _voices),
        backgroundSound: _pick(rng, _backgroundSounds),
      ),
      DailyRoutineBreathing(
        title: 'Afternoon breathing',
        description:
            '${_pick(rng, const ['Calm inhalations with steady counts', 'Reset with paced breathing', 'Slow breath to regain control'])} · $modifier2',
        durationMinutes: afternoonDuration,
        imageAsset: 'assets/images/daily_routine.svg',
        badgeText: breathingMood,
        goal: _pick(rng, _goals),
        voiceStyle: _pick(rng, _voices),
        backgroundSound: _pick(rng, _backgroundSounds),
        inhaleSeconds: breathingPattern.inhale,
        exhaleSeconds: breathingPattern.exhale,
      ),
      DailyRoutineMeditation(
        title: 'Evening relaxation',
        description: '$eveningDescBase · $modifier3',
        durationMinutes: eveningDuration,
        imageAsset: 'assets/images/evening_meditation.png',
        badgeText: 'NIGHT WIND-DOWN',
        goal: _pick(rng, _goals),
        voiceStyle: _pick(rng, _voices),
        backgroundSound: _pick(rng, _backgroundSounds),
      ),
    ];

    routineItems.value = items;
    dayLabel.value = dayName;

    if (reshuffle) {
      // сбрасываем прогресс на день, т.к. задания поменялись
      unawaited(_prefs.resetRoutineProgress(date));
    }
  }

  /// Возвращает следующую активность для запуска и сохраняет факт её открытия.
  /// Если всё пройдено — вернёт null.
  Future<DailyRoutineActivity?> startNextActivity({DateTime? forDate}) async {
    final date = forDate ?? DateTime.now();
    final items = routineItems.value;

    if (items.isEmpty) return null;

    final nextIndex = _prefs.getRoutineNextIndex(date);
    if (nextIndex >= items.length) return null;

    final activity = items[nextIndex];

    await _prefs.addRoutineOpened(date, {
      'index': nextIndex,
      'title': activity.title,
      'openedAt': DateTime.now().toIso8601String(),
    });

    await _prefs.setRoutineNextIndex(date, nextIndex + 1);

    return activity;
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
