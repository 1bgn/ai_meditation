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
  final AudioPlayer _backgroundSoundPlayer = AudioPlayer();

  final isPlaying = signal(true);
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
    String? backgroundSound,
  }) async {
    error.value = null;
    try {
      _bindPlayerStreams();
      final source =
          preloadedSource ??
          await _ttsService.buildAudioSource(
            script,
            language: _playerLanguage,
            pitch: 1.0,
            rate: 0.6,
            voiceStyle: voiceStyle,
          );
      await _player.setAudioSource(source);
      _player.play();

      // Start background sound if selected
      if (backgroundSound != null && backgroundSound != 'None') {
        await _startBackgroundSound(backgroundSound);
      }
    } catch (e) {
      error.value = e.toString();
    }
  }

  Future<void> _startBackgroundSound(String backgroundSound) async {
    try {
      // Map background sound names to audio files
      final backgroundSoundMap = {
        'Ocean': 'assets/sounds/ocean_sound.wav',
        'Rain': 'assets/sounds/rain_sound.wav',
        'Forest': 'assets/sounds/forest_sound.wav',
        'Nature': 'assets/sounds/nature_sound.wav',
        'Ambient music': 'assets/sounds/ambient_sound.wav',
      };

      final soundFile = backgroundSoundMap[backgroundSound];
      if (soundFile != null) {
        await _backgroundSoundPlayer.setAudioSource(
          AudioSource.asset(soundFile),
        );
        _backgroundSoundPlayer.setLoopMode(LoopMode.all);
        await _backgroundSoundPlayer.play();
      }
    } catch (e) {
      error.value = 'Failed to play background sound: $e';
    }
  }

  Future<void> togglePlayPause() async {
    print("isPlaying.value ${isPlaying.value}");
    print("_player.playing ${_player.playing}");
    print("_backgroundSoundPlayer.playing ${_backgroundSoundPlayer.playing}");
    if (isPlaying.value) {
      print("ON PAUSE");
      _player.pause();
      _backgroundSoundPlayer.pause();
    } else {
      print("ON PLAY");
      // When resuming, ensure both players are at the same position
      _player.play();
      _backgroundSoundPlayer.play();
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

  Future<void> stop() async {
    await _player.stop();
    await _backgroundSoundPlayer.stop();
  }

  void dispose() {
    _positionSub?.cancel();
    _durationSub?.cancel();
    _playingSub?.cancel();
    _player.dispose();
    _backgroundSoundPlayer.dispose();
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
