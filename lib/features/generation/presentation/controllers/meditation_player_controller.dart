import 'dart:async';

import 'package:ai_meditation/core/tts/build_tts.dart';
import 'package:injectable/injectable.dart';
import 'package:just_audio/just_audio.dart';
import 'package:signals/signals.dart';

import '../../../../core/tts/tts_service.dart';

@LazySingleton()
class MeditationPlayerController {
  MeditationPlayerController(this._ttsService);

  final TtsService _ttsService;

  final AudioPlayer _player = AudioPlayer();
  final AudioPlayer _backgroundSoundPlayer = AudioPlayer();

  final isPlaying = signal(false);
  final error = signal<String?>(null);

  /// Глобальная позиция (по всей дорожке TTS).
  final position = signal(Duration.zero);

  /// Длительность текущего чанка (можно оставить для дебага/вторичных нужд).
  final duration = signal(Duration.zero);

  /// Глобальная длительность (по всем чанкам).
  final trackDuration = signal(Duration.zero);

  final backgroundSound = signal("None");

  StreamSubscription<Duration>? _positionSub;
  StreamSubscription<Duration?>? _durationSub;
  StreamSubscription<bool>? _playingSub;

  // Для глобального позиционирования.
  List<Duration> _chunkDurations = const [];
  List<Duration> _prefix =
      const []; // prefix[i] = сумма длительностей чанков [0..i-1]

  Future<void> start({
    required String script,
    required String voiceStyle,
    required BuiltTts buildTts,
    AudioSource? preloadedSource,
    String? backgroundSound,
  }) async {
    error.value = null;

    // Важно: even если source уже готов, durations нужны для глобального seek/позиции.
    _setChunkDurations(buildTts.chunkDurations);
    trackDuration.value = buildTts.total;

    try {
      _bindPlayerStreams();

      final source = preloadedSource ?? buildTts.source;

      await _player.setAudioSource(
        source,
        preload: true,
        initialPosition: Duration.zero,
      );

      _player.play();

      if (backgroundSound != null && backgroundSound != 'None') {
        this.backgroundSound.value = backgroundSound;
        await startBackgroundSound(backgroundSound);
      }
    } catch (e) {
      error.value = e.toString();
    }
  }

  Future<void> setVolume(double volume) async {
    await _player.setVolume(volume);
    await _backgroundSoundPlayer.setVolume(volume);
  }

  Future<void> startBackgroundSound(String backgroundSound) async {
    final backgroundSoundMap = {
      'Rain': 'assets/sounds/rain_sound.wav',
      'Nature': 'assets/sounds/nature_sound.wav',
      'Ambient Music': 'assets/sounds/ambient_sound.wav',
    };

    final keys = backgroundSoundMap.keys.toList(growable: false);
    final values = backgroundSoundMap.values.toList(growable: false);

    final index = keys.indexOf(backgroundSound);
    if (index < 0) return;

    // Плейлист фоновых звуков.
    final playlist = ConcatenatingAudioSource(
      useLazyPreparation: true,
      children: values.map(AudioSource.asset).toList(growable: false),
    );

    await _backgroundSoundPlayer.setAudioSource(
      playlist,
      preload: true,
      initialIndex: index,
      initialPosition: Duration.zero,
    );

    await _backgroundSoundPlayer.setLoopMode(LoopMode.all);
    _backgroundSoundPlayer.play();
  }

  Future<void> setBackgroundSound(String backgroundSound) async {
    this.backgroundSound.value = backgroundSound;

    if (backgroundSound == 'None') {
      await _backgroundSoundPlayer.pause();
      return;
    }

    // Если фон уже загружен плейлистом — просто прыгнем по index.
    final idx = switch (backgroundSound) {
      'Rain' => 0,
      'Nature' => 1,
      'Ambient Music' => 2,
      _ => -1,
    };
    if (idx < 0) return;
    await _backgroundSoundPlayer.seek(Duration.zero, index: idx);

   // await _backgroundSoundPlayer.clearAudioSources();
    _backgroundSoundPlayer.play();
  }

  Future<void> togglePlayPause() async {
    if (_player.playing) {
      await _player.pause();
      await _backgroundSoundPlayer.pause();
    } else {
      _player.play();
      if (backgroundSound.value != 'None') {
        _backgroundSoundPlayer.play();
      }
    }
  }

  /// Глобальная перемотка на delta от текущей глобальной позиции.
  Future<void> seekBy(Duration delta) async {
    await seekGlobal(position.value + delta);
  }

  /// Глобальная перемотка (секунды от начала всей дорожки).
  Future<void> seek(int seconds) async {
    await seekGlobal(Duration(seconds: seconds));
  }

  /// Глобальный seek: переводим target в (index, offset) и вызываем seek(offset, index: i).
  Future<void> seekGlobal(Duration target) async {
    if (_chunkDurations.isEmpty) return;

    // clamp to [0..trackDuration]
    if (target <= Duration.zero) {
      _player.seek(Duration.zero, index: 0);
      return;
    }

    final total = trackDuration.value;
    if (total > Duration.zero && target >= total) {
      final last = _chunkDurations.length - 1;
      final lastPos = _chunkDurations[last];
      _player.seek(lastPos, index: last);
      return;
    }

    // Найдём i: prefix[i] <= target < prefix[i] + chunkDurations[i]
    var i = 0;
    while (i + 1 < _chunkDurations.length &&
        target >= _prefix[i] + _chunkDurations[i]) {
      i++;
    }

    final within = target - _prefix[i];

    // Внутри чанка тоже клампим.
    final chunkLen = _chunkDurations[i];
    final clampedWithin = within < Duration.zero
        ? Duration.zero
        : (within > chunkLen ? chunkLen : within);

    await _player.seek(clampedWithin, index: i);
  }

  Future<void> stop() async {
    await _player.stop();
    await _backgroundSoundPlayer.stop();
  }

  Future<void> stopBackground() async {
    await _backgroundSoundPlayer.stop();
  }

  void dispose() {
    _positionSub?.cancel();
    _durationSub?.cancel();
    _playingSub?.cancel();
    _player.dispose();
    _backgroundSoundPlayer.dispose();
  }

  String readTime(Duration d) {
    final minutes = d.inMinutes.remainder(60);
    final seconds = d.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void _setChunkDurations(List<Duration> d) {
    _chunkDurations = List<Duration>.from(d);

    final prefix = List<Duration>.filled(_chunkDurations.length, Duration.zero);
    var acc = Duration.zero;
    for (var i = 0; i < _chunkDurations.length; i++) {
      prefix[i] = acc;
      acc += _chunkDurations[i];
    }
    _prefix = prefix;
  }

  void _bindPlayerStreams() {
    // Глобальная позиция: prefix[currentIndex] + localPosition
    _positionSub ??= _player.positionStream.listen((localPos) {
      final idx = _player.currentIndex ?? 0;
      final base = (idx >= 0 && idx < _prefix.length)
          ? _prefix[idx]
          : Duration.zero;
      position.value = base + localPos;
    });

    _durationSub ??= _player.durationStream.listen((value) {
      duration.value = value ?? Duration.zero;
    });

    _playingSub ??= _player.playingStream.listen((value) {
      isPlaying.value = value;
    });
  }
}

const _playerLanguage = 'en-US';
