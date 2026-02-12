import 'dart:io';
import 'dart:typed_data';

import 'package:ai_meditation/core/tts/build_tts.dart';
import 'package:audio_session/audio_session.dart';
import 'package:injectable/injectable.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kokoro_tts_flutter/kokoro_tts_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../../features/generation/data/datasources/eleven_labs_remote_datasource.dart';
import '../../features/generation/data/models/eleven_labs_request.dart';

@lazySingleton
class TtsService {
  TtsService(this._elevenLabs);

  final ElevenLabsRemoteDatasource _elevenLabs;

  Kokoro? _kokoro;
  bool _kokoroReady = false;
  List<String> _availableVoices = [];

  // Чтобы можно было подчистить временные wav/mp3 после проигрывания/экрана.
  final List<File> _tempFiles = [];

  Future<BuiltTts> buildAudioSource(
    String text, {
    required String language,
    required double
    pitch, // сейчас не используется Kokoro, оставил как API-контракт
    required double rate,
    String? voiceStyle,
  }) async {
    await _configureAudioSession();

    final normalizedLanguage = _normalizeLanguage(
      _detectLanguage(text, fallback: language),
    );

    final styleKey = _normalizeVoiceStyle(voiceStyle);

    final maxChars = normalizedLanguage.startsWith('ru')
        ? _elevenLabsMaxChars
        : _kokoroMaxChars;

    final speed = _applyStyleSpeed(
      styleKey,
      _rateToSpeed(rate),
      normalizedLanguage,
    );

    final chunks = _splitText(text, maxChars: maxChars);
    if (chunks.isEmpty) {
      throw StateError('TTS received empty text.');
    }

    // Если вернёшь ElevenLabs для ru, лучше тоже вернуть Duration.
    // if (normalizedLanguage.startsWith('ru')) {
    //   final src = await _buildElevenLabsSource(chunks, voiceStyle: voiceStyle);
    //   return BuiltTts(
    //     source: src,
    //     total: Duration.zero,
    //     chunkDurations: List.filled(chunks.length, Duration.zero),
    //   );
    // }

    await _ensureKokoroInitialized();

    final voiceId = _resolveKokoroVoiceId(
      styleKey: styleKey,
      language: normalizedLanguage,
    );

    // Быстрый дебаг: убедись, что реально меняются voiceId/speed
    // ignore: avoid_print
    print(
      'TTS styleRaw=$voiceStyle styleKey=$styleKey -> voiceId=$voiceId speed=$speed lang=$normalizedLanguage',
    );

    final sources = <AudioSource>[];
    final chunkDurations = <Duration>[];
    var total = Duration.zero;

    for (var i = 0; i < chunks.length; i++) {
      final result = await _kokoro!.createTTS(
        text: chunks[i],
        voice: voiceId,
        speed: speed,
        lang: normalizedLanguage,
      );

      final pcm = result.toInt16PCM();
      if (pcm.isEmpty) {
        throw StateError('TTS produced empty audio.');
      }

      final d = _pcmDuration(
        pcmSamples: pcm.length,
        sampleRate: result.sampleRate,
      );
      chunkDurations.add(d);
      total += d;

      final file = await _writeWavFileFromPcm(
        pcm,
        sampleRate: result.sampleRate,
        index: i,
      );

      _tempFiles.add(file);
      sources.add(AudioSource.file(file.path));
    }

    final playlist = ConcatenatingAudioSource(
      useLazyPreparation: false,
      children: sources,
    );

    return BuiltTts(
      source: playlist,
      total: total,
      chunkDurations: chunkDurations,
    );
  }

  /// Вызывай, например, в dispose() экрана/сервиса, чтобы не забивать temp.
  Future<void> cleanupTempFiles() async {
    for (final f in List<File>.from(_tempFiles)) {
      try {
        if (await f.exists()) {
          await f.delete();
        }
      } catch (_) {
        // игнорируем
      }
    }
    _tempFiles.clear();
  }

  Duration _pcmDuration({required int pcmSamples, required int sampleRate}) {
    // mono 16-bit PCM: pcmSamples == number of samples
    final ms = (pcmSamples * 1000) ~/ sampleRate;
    return Duration(milliseconds: ms);
  }

  Future<AudioSource> _buildElevenLabsSource(
    List<String> chunks, {
    required String? voiceStyle,
  }) async {
    final voiceId = _resolveElevenLabsVoiceId(voiceStyle);
    final sources = <AudioSource>[];

    for (var i = 0; i < chunks.length; i++) {
      final request = ElevenLabsRequest(
        text: chunks[i],
        modelId: _elevenLabsModelId,
        voiceSettings: ElevenLabsVoiceSettings(
          stability: _elevenLabsStability,
          similarityBoost: _elevenLabsSimilarity,
        ),
      );

      final bytes = await _elevenLabs.generateSpeech(voiceId, request);
      final file = await _writeMp3File(bytes, index: i);

      _tempFiles.add(file);
      sources.add(AudioSource.file(file.path));
    }

    return ConcatenatingAudioSource(
      useLazyPreparation: true,
      children: sources,
    );
  }

  Future<void> _ensureKokoroInitialized() async {
    if (_kokoroReady) return;

    await _configureAudioSession();

    const config = KokoroConfig(
      modelPath: _kokoroModelAsset,
      voicesPath: _kokoroVoicesAsset,
    );

    _kokoro = Kokoro(config);
    await _kokoro!.initialize();
    _availableVoices = _kokoro!.getVoices();
    _kokoroReady = true;

    // ignore: avoid_print
    print(
      'Kokoro voices loaded: ${_availableVoices.length} -> $_availableVoices',
    );
  }

  Future<void> _configureAudioSession() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
  }

  Future<File> _writeWavFileFromPcm(
    Int16List pcm, {
    required int sampleRate,
    required int index,
  }) async {
    final dir = await getTemporaryDirectory();
    final file = File(
      '${dir.path}/kokoro_${DateTime.now().millisecondsSinceEpoch}_$index.wav',
    );
    final bytes = _encodeWav(pcm, sampleRate: sampleRate);
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }

  Future<File> _writeMp3File(List<int> bytes, {required int index}) async {
    final dir = await getTemporaryDirectory();
    final file = File(
      '${dir.path}/elevenlabs_${DateTime.now().millisecondsSinceEpoch}_$index.mp3',
    );
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }

  Uint8List _encodeWav(Int16List pcm, {required int sampleRate}) {
    const numChannels = 1;
    const bitsPerSample = 16;

    final byteRate = sampleRate * numChannels * bitsPerSample ~/ 8;
    final blockAlign = numChannels * bitsPerSample ~/ 8;
    final dataLength = pcm.length * 2;
    final totalLength = 44 + dataLength;

    final buffer = BytesBuilder();
    buffer
      ..add(_ascii('RIFF'))
      ..add(_int32LE(totalLength - 8))
      ..add(_ascii('WAVE'))
      ..add(_ascii('fmt '))
      ..add(_int32LE(16))
      ..add(_int16LE(1))
      ..add(_int16LE(numChannels))
      ..add(_int32LE(sampleRate))
      ..add(_int32LE(byteRate))
      ..add(_int16LE(blockAlign))
      ..add(_int16LE(bitsPerSample))
      ..add(_ascii('data'))
      ..add(_int32LE(dataLength))
      // view на buffer корректен, потому что Int16List хранится в ByteBuffer.
      ..add(Uint8List.view(pcm.buffer, pcm.offsetInBytes, dataLength));

    return buffer.toBytes();
  }

  Uint8List _ascii(String value) => Uint8List.fromList(value.codeUnits);

  Uint8List _int16LE(int value) {
    final data = ByteData(2);
    data.setInt16(0, value, Endian.little);
    return data.buffer.asUint8List();
  }

  Uint8List _int32LE(int value) {
    final data = ByteData(4);
    data.setInt32(0, value, Endian.little);
    return data.buffer.asUint8List();
  }

  List<String> _splitText(String text, {required int maxChars}) {
    final sanitized = text.replaceAll(RegExp(r'\s+'), ' ').trim();
    if (sanitized.isEmpty) return [];

    final sentences = sanitized.split(RegExp(r'(?<=[.!?])\s+'));
    final chunks = <String>[];
    var buffer = StringBuffer();

    void flushBuffer() {
      final value = buffer.toString().trim();
      if (value.isNotEmpty) chunks.add(value);
      buffer = StringBuffer();
    }

    for (final sentence in sentences) {
      if (sentence.length > maxChars) {
        flushBuffer();
        chunks.addAll(_splitLongSentence(sentence, maxChars));
        continue;
      }

      final next = buffer.isEmpty ? sentence : '${buffer.toString()} $sentence';

      if (next.length > maxChars) {
        flushBuffer();
        buffer.write(sentence);
      } else {
        buffer = StringBuffer(next);
      }
    }

    flushBuffer();
    return chunks;
  }

  List<String> _splitLongSentence(String text, int maxChars) {
    final words = text.split(' ');
    final parts = <String>[];
    var buffer = StringBuffer();

    for (final word in words) {
      final next = buffer.isEmpty ? word : '${buffer.toString()} $word';
      if (next.length > maxChars) {
        final value = buffer.toString().trim();
        if (value.isNotEmpty) parts.add(value);
        buffer = StringBuffer(word);
      } else {
        buffer = StringBuffer(next);
      }
    }

    final last = buffer.toString().trim();
    if (last.isNotEmpty) parts.add(last);
    return parts;
  }

  String _resolveKokoroVoiceId({
    required String styleKey,
    required String language,
  }) {
    final lang = language.toLowerCase();
    final preferred = <String>[];

    // 1) Сначала стиль — чтобы он реально влиял
    final styleVoices = _styleToKokoroVoices[styleKey];
    if (styleVoices != null) preferred.addAll(styleVoices);

    // 2) Потом базовый пул по языку (можно расширять под другие языки)
    if (lang.startsWith('en')) preferred.addAll(_enVoices);

    // 3) Выбор по приоритету
    for (final id in preferred) {
      if (_availableVoices.contains(id)) return id;
    }

    // 4) Фолбэки
    if (_availableVoices.contains(_defaultVoice)) return _defaultVoice;
    return _availableVoices.isNotEmpty ? _availableVoices.first : _defaultVoice;
  }
}

// --------------------------
// Конфигурация Kokoro
// --------------------------

const _kokoroModelAsset = 'assets/kokoro/kokoro-v1.0.onnx';
const _kokoroVoicesAsset = 'assets/kokoro/voices.json';
const _kokoroLanguageFallback = 'en-us';
const _kokoroMaxChars = 500;

// Список голосов (пример — сверяй с getVoices()).
final _enVoices = <String>['af_heart', 'af_sky', 'am_adam', 'am_michael'];

final _softVoices = <String>['af_heart'];
final _warmVoices = <String>['af_sky'];
final _deepVoices = <String>['am_adam'];
final _neutralVoices = <String>['af_sky', 'am_michael'];
final _meditationVoices = <String>['af_heart', 'af_sky'];

const _defaultVoice = 'af_heart';

// ключи ТОЛЬКО lowercase
final Map<String, List<String>> _styleToKokoroVoices = {
  'soft': _softVoices,
  'warm': _warmVoices,
  'deep': _deepVoices,
  'neutral': _neutralVoices,
  'meditation': _meditationVoices,
};

// --------------------------
// Конфигурация ElevenLabs
// --------------------------

const _elevenLabsMaxChars = 900;
const _elevenLabsModelId = 'eleven_multilingual_v2';
const _elevenLabsStability = 0.35;
const _elevenLabsSimilarity = 0.85;

// Пример ID голосов (берутся из кабинета ElevenLabs).
const _ruVoiceDefault = 'pNInz6obpgDQGcFmaJgB';
const _ruVoiceSoft = 'EXAVITQu4vr4xnSDxMaL';
const _ruVoiceDeep = 'TxGEqnHWrfWFTfGW9XjX';

// ключи ТОЛЬКО lowercase
const Map<String, String> _styleToElevenLabsVoice = {
  'soft': _ruVoiceSoft,
  'deep': _ruVoiceDeep,
  'warm': _ruVoiceDefault,
  'neutral': _ruVoiceDefault,
};

String _resolveElevenLabsVoiceId(String? voiceStyle) {
  final styleKey = _normalizeVoiceStyle(voiceStyle);
  return _styleToElevenLabsVoice[styleKey] ?? _ruVoiceDefault;
}

// --------------------------
// Общие утилиты
// --------------------------

double _rateToSpeed(double rate) => (0.5 + rate).clamp(0.5, 2.0).toDouble();

String _normalizeLanguage(String language) {
  final normalized = language.trim().toLowerCase().replaceAll('_', '-');
  return normalized.isEmpty ? _kokoroLanguageFallback : normalized;
}

String _detectLanguage(String text, {required String fallback}) {
  final hasCyrillic = RegExp(r'[А-Яа-яЁё]').hasMatch(text);
  return hasCyrillic ? 'ru-ru' : fallback;
}

/// Нормализуем то, что реально приходит: "Deep"/"deep"/"DEEP"/"Neutra".
String _normalizeVoiceStyle(String? raw) {
  final s = (raw ?? '').trim().toLowerCase();
  if (s.isEmpty) return '';

  // убираем пробелы/символы на всякий случай
  final cleaned = s.replaceAll(RegExp(r'[^a-z]'), '');

  switch (cleaned) {
    case 'deep':
      return 'deep';
    case 'soft':
      return 'soft';
    case 'warm':
      return 'warm';
    case 'neutral':
    case 'neutra':
      return 'neutral';
    case 'meditation':
      return 'meditation';
    default:
      return cleaned;
  }
}

double _applyStyleSpeed(String styleKey, double baseSpeed, String language) {
  if (language.startsWith('ru')) return baseSpeed;

  if (styleKey == 'soft') return (baseSpeed * 0.85).clamp(0.5, 2.0).toDouble();
  if (styleKey == 'neutral') {
    return (baseSpeed * 0.9).clamp(0.5, 2.0).toDouble();
  }
  if (styleKey == 'deep') return (baseSpeed * 0.95).clamp(0.5, 2.0).toDouble();

  return baseSpeed;
}
