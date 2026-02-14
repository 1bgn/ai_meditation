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

  int _inhaleBlockSeconds = 4;
  int _exhaleBlockSeconds = 4;

  void start({String? mood, Duration? duration, VoidCallback? onSessionEnd}) {
    if (isRunning.value) return;

    _mood = mood;
    _onSessionEnd = onSessionEnd;

    totalDuration.value = duration ?? const Duration(minutes: 5);
    timeRemaining.value = totalDuration.value;

    _applyMoodPattern(_mood);

    isRunning.value = true;

    // Стартуем с вдоха
    isInhale.value = true;
    _scheduleNextRhythmFlip();

    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
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

  void _applyMoodPattern(String? mood) {
    final m = (mood ?? '').toLowerCase();

    switch (m) {
      case 'calm':
        _inhaleBlockSeconds = 4;
        _exhaleBlockSeconds = 6;
        break;

      case 'neutral':
        _inhaleBlockSeconds = 4;
        _exhaleBlockSeconds = 4;
        break;

      case 'stressed':
        _inhaleBlockSeconds = 8;
        _exhaleBlockSeconds = 8;
        break;

      case 'anxius':
      case 'anxious':
        _inhaleBlockSeconds = 11;
        _exhaleBlockSeconds = 8;
        break;

      default:
        _inhaleBlockSeconds = 4;
        _exhaleBlockSeconds = 4;
    }
  }

  void _scheduleNextRhythmFlip() {
    _timer?.cancel();

    final seconds = isInhale.value ? _inhaleBlockSeconds : _exhaleBlockSeconds;

    _timer = Timer(Duration(seconds: seconds), () {
      if (!isRunning.value) return;
      isInhale.value = !isInhale.value;
      _scheduleNextRhythmFlip();
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
