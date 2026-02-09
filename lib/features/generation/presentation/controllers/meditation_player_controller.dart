import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:just_audio/just_audio.dart';
import 'package:signals/signals.dart';

import '../../../../core/tts/tts_service.dart';

@injectable
class MeditationPlayerController {
  MeditationPlayerController(this._ttsService);

  final TtsService _ttsService;
  final AudioPlayer _player = AudioPlayer();

  final isPlaying = signal(false);
  final error = signal<String?>(null);
  final position = signal(Duration.zero);
  final duration = signal(Duration.zero);

  StreamSubscription<Duration>? _positionSub;
  StreamSubscription<Duration?>? _durationSub;
  StreamSubscription<bool>? _playingSub;

  Future<void> start({
    required String script,
    required String voiceStyle,
    AudioSource? preloadedSource,
  }) async {
    error.value = null;
    try {
      _bindPlayerStreams();
      final source = preloadedSource ??
          await _ttsService.buildAudioSource(
            script,
            language: _playerLanguage,
            pitch: 1.0,
            rate: 0.6,
            voiceStyle: voiceStyle,
          );
      await _player.setAudioSource(source);
      await _player.play();
    } catch (e) {
      error.value = e.toString();
    }
  }

  Future<void> togglePlayPause() async {
    if (_player.playing) {
      await _player.pause();
    } else {
      await _player.play();
    }
  }

  Future<void> seekBy(Duration delta) async {
    final next = _player.position + delta;
    final total = _player.duration ?? Duration.zero;
    final clamped = next < Duration.zero
        ? Duration.zero
        : (next > total ? total : next);
    await _player.seek(clamped);
  }

  Future<void> stop() async => _player.stop();

  void dispose() {
    _positionSub?.cancel();
    _durationSub?.cancel();
    _playingSub?.cancel();
    _player.dispose();
  }

  void _bindPlayerStreams() {
    _positionSub ??= _player.positionStream.listen(
      (value) => position.value = value,
    );
    _durationSub ??= _player.durationStream.listen(
      (value) => duration.value = value ?? Duration.zero,
    );
    _playingSub ??= _player.playingStream.listen(
      (value) => isPlaying.value = value,
    );
  }
}

const _playerLanguage = 'en-US';
