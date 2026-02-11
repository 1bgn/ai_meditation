import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';
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

  final isPlaying = signal(true);
  final error = signal<String?>(null);
  final position = signal(Duration.zero);
  final duration = signal(Duration.zero);
  final trackDuration = signal(Duration.zero);
  final backgroundSound = signal("None");
  StreamSubscription<Duration>? _positionSub;
  StreamSubscription<Duration?>? _durationSub;
  StreamSubscription<bool>? _playingSub;

  Future<void> start({
    required String script,
    required String voiceStyle,
    required Duration durationTrack,
    AudioSource? preloadedSource,
    String? backgroundSound,
  }) async {
    print("init background sound $backgroundSound");
    error.value = null;
    trackDuration.value = durationTrack;
    try {
      _bindPlayerStreams();
      final source =
          preloadedSource ??
          (await _ttsService.buildAudioSource(
            script,
            language: _playerLanguage,
            pitch: 1.0,
            rate: 0.6,

            voiceStyle: voiceStyle,
          )).$1;
      await _player.setAudioSource(source, preload: true);
      _player.play();

      // Start background sound if selected
      if (backgroundSound != null && backgroundSound != 'None') {
        this.backgroundSound.value = backgroundSound;
        startBackgroundSound(backgroundSound);
      }
    } catch (e) {
      error.value = e.toString();
    }
  }

  Future<void> setVolume(double volume) async {
    print("setVolume ${volume}");
    _player.setVolume(volume);
    _backgroundSoundPlayer.setVolume(volume);
  }

  Future<void> startBackgroundSound(String backgroundSound) async {
    // Map background sound names to audio files
    final backgroundSoundMap = {
      'Rain': 'assets/sounds/rain_sound.wav',
      'Nature': 'assets/sounds/nature_sound.wav',
      'Ambient Music': 'assets/sounds/ambient_sound.wav',
    };
    final backgroundMap = {'Rain': 0, 'Nature': 1, 'Ambient Music': 2};
    _backgroundSoundPlayer.seek(
      Duration(seconds: 0),
      index: backgroundMap[backgroundSound],
    );
    await _backgroundSoundPlayer.setAudioSources(
      backgroundSoundMap.values.map((e) => AudioSource.asset(e)).toList(),
    );
    await _backgroundSoundPlayer.setLoopMode(LoopMode.one);
    await _backgroundSoundPlayer.play();
  }

  Future<void> setBackgroundSound(String backgroundSound) async {
    // Map background sound names to audio files
    final backgroundMap = {'Rain': 0, 'Nature': 1, 'Ambient Music': 2};

    // final soundFile = backgroundSoundMap[backgroundSound];

    // if (soundFile != null) {

    // _backgroundSoundPlayer.setVolume(1);
    this.backgroundSound.value = backgroundSound;
    _backgroundSoundPlayer.setLoopMode(LoopMode.all);
    _backgroundSoundPlayer.seek(
      Duration(seconds: 0),
      index: backgroundMap[backgroundSound],
    );
    _backgroundSoundPlayer.play();

    print("setBackgroundSound ${backgroundMap[backgroundSound]}");
    // }
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
      print("ON PLAY ${backgroundSound.value}");
      _player.play();
      if (backgroundSound.value != 'None') {
        _backgroundSoundPlayer.play();
      }
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

  Future<void> seek(int seconds) async {
    ;
    await _player.seek(Duration(seconds: seconds));
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

  String readTime(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void _bindPlayerStreams() {
    _positionSub ??= _player.positionStream.listen(
      (value) => position.value = value,
    );
    _durationSub ??= _player.durationStream.listen((value) {
      duration.value = value ?? Duration.zero;
      print("VCDSVSDVSDsd ${value?.inSeconds}");
    });
    _playingSub ??= _player.playingStream.listen(
      (value) => isPlaying.value = value,
    );
  }
}

Future<Duration> wavAssetDuration(String assetPath) async {
  final data = await rootBundle.load(assetPath);
  final bytes = data.buffer.asUint8List();
  final bd = ByteData.sublistView(bytes);

  int u16le(int o) => bd.getUint16(o, Endian.little);
  int u32le(int o) => bd.getUint32(o, Endian.little);

  // "RIFF"...."WAVE"
  if (bytes.length < 12 ||
      String.fromCharCodes(bytes.sublist(0, 4)) != 'RIFF' ||
      String.fromCharCodes(bytes.sublist(8, 12)) != 'WAVE') {
    throw FormatException('Not a RIFF/WAVE file');
  }

  int offset = 12;

  int? byteRate;
  int? dataSize;

  while (offset + 8 <= bytes.length) {
    final id = String.fromCharCodes(bytes.sublist(offset, offset + 4));
    final size = u32le(offset + 4);
    final chunkDataStart = offset + 8;

    if (chunkDataStart + size > bytes.length) break;

    if (id == 'fmt ') {
      // fmt chunk: byteRate at +8 from fmt start for PCM-like layouts
      // (AudioFormat u16 at +0, NumChannels u16 +2, SampleRate u32 +4, ByteRate u32 +8, ...)
      byteRate = u32le(chunkDataStart + 8);
    } else if (id == 'data') {
      dataSize = size;
    }

    // Chunks are word-aligned: pad to even.
    offset = chunkDataStart + size + (size.isOdd ? 1 : 0);

    if (byteRate != null && dataSize != null) break;
  }

  if (byteRate == null || dataSize == null || byteRate == 0) {
    throw FormatException('Cannot determine WAV duration (missing fmt/data)');
  }

  final seconds = dataSize / byteRate;
  return Duration(milliseconds: (seconds * 1000).round());
}

const _playerLanguage = 'en-US';
