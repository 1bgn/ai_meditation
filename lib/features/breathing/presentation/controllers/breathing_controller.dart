import 'package:injectable/injectable.dart';
import 'package:signals/signals.dart';

import '../../domain/entities/breathing_options.dart';

@injectable
class BreathingController {
  final options = signal(
    const BreathingOptions(
      mood: 'Calm',
      durationMinutes: 3,
    ),
  );

  void updateMood(String mood) =>
      options.value = options.value.copyWith(mood: mood);

  void updateDuration(int minutes) =>
      options.value = options.value.copyWith(durationMinutes: minutes);
}
