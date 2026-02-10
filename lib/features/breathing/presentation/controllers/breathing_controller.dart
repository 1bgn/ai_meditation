import 'package:injectable/injectable.dart';
import 'package:signals/signals.dart';

import '../../domain/entities/breathing_options.dart';

@lazySingleton
class BreathingController {
  final options = signal(
    const BreathingOptions(
      mood: null,
      durationMinutes: null,
    ),
  );

  void updateMood(String mood) =>
      options.value = options.value.copyWith(mood: mood);

  void updateDuration(int minutes) =>
      options.value = options.value.copyWith(durationMinutes: minutes);
}
