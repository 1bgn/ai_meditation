import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:signals/signals.dart';

@injectable
class BreathingSessionController {
  final isRunning = signal(false);
  final isInhale = signal(true);
  final timeRemaining = signal(Duration.zero);
  final totalDuration = signal(Duration.zero);

  Timer? _timer;
  Timer? _countdownTimer;
  String? _mood;
  VoidCallback? _onSessionEnd;

  void start({String? mood, Duration? duration, VoidCallback? onSessionEnd}) {
    if (isRunning.value) {
      return;
    }

    _mood = mood;
    _onSessionEnd = onSessionEnd;
    // totalDuration.value =
    //     duration ?? const Duration(minutes: 5); // Default to 5 minutes
    //  totalDuration.value =
    //     Duration(seconds: 0);
    timeRemaining.value = totalDuration.value;

    isRunning.value = true;

    // Start breathing rhythm timer (inhale/exhale cycle)
    _timer = Timer.periodic(
      const Duration(seconds: 4),
      (_) => isInhale.value = !isInhale.value,
    );

    // Start countdown timer
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeRemaining.value.inSeconds <= 1) {
        timeRemaining.value = Duration.zero;
        _endSession();
      } else {
        timeRemaining.value = Duration(
          seconds: timeRemaining.value.inSeconds - 1,
        );
      }
    });
  }

  void _endSession() {
    stop();
    _onSessionEnd?.call();
  }

  void stop() {
    _timer?.cancel();
    _countdownTimer?.cancel();
    _timer = null;
    _countdownTimer = null;
    isRunning.value = false;
  }

  void dispose() => stop();
}
