import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:signals/signals.dart';

@injectable
class BreathingSessionController {
  final isRunning = signal(false);
  final isInhale = signal(true);

  Timer? _timer;

  void start() {
    if (isRunning.value) {
      return;
    }
    isRunning.value = true;
    _timer = Timer.periodic(
      const Duration(seconds: 4),
      (_) => isInhale.value = !isInhale.value,
    );
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
    isRunning.value = false;
  }

  void dispose() => stop();
}
