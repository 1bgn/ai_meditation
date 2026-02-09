import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:injectable/injectable.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:piper_tts/piper_tts.dart';

@lazySingleton
class TtsService {
  TtsService(this._tts);

  final FlutterTts _tts;
  final AudioPlayer _player = AudioPlayer();
  bool _piperReady = false;

  Future<void> speak(
    String text, {
    required String language,
    required double pitch,
    required double rate,
  }) async {
    final usedPiper = await _trySpeakWithPiper(text);
    if (usedPiper) {
      return;
    }
    await _tts.setLanguage(language);
    await _tts.setPitch(pitch);
    await _tts.setSpeechRate(rate);
    await _tts.speak(text);
  }

  Future<void> stop() async {
    await _player.stop();
    await _tts.stop();
  }

  Future<bool> _trySpeakWithPiper(String text) async {
    if (!Platform.isAndroid) {
      return false;
    }
    try {
      if (!_piperReady) {
        await _preparePiperModel();
        _piperReady = true;
      }
      final file = await Piper.generateSpeech(text);
      await _player.setFilePath(file.path);
      await _player.play();
      return true;
    } catch (error) {
      if (_forcePiperOnAndroid) {
        throw StateError(
          'Piper TTS failed: $error. '
          'Ensure model files exist in assets/piper and '
          'libpiper.so is packaged under android/app/src/main/jniLibs.',
        );
      }
      return false;
    }
  }

  Future<void> _preparePiperModel() async {
    final supportDir = await getApplicationSupportDirectory();
    final modelFile = File('${supportDir.path}/$_piperModelFile');
    final configFile = File('${supportDir.path}/$_piperConfigFile');
    if (!modelFile.existsSync()) {
      await _copyAssetToFile(_piperModelAsset, modelFile);
    }
    if (!configFile.existsSync()) {
      await _copyAssetToFile(_piperConfigAsset, configFile);
    }
    Piper.modelPath = modelFile.path;
  }

  Future<void> _copyAssetToFile(String asset, File target) async {
    final bytes = await rootBundle.load(asset);
    await target.create(recursive: true);
    await target.writeAsBytes(
      bytes.buffer.asUint8List(),
      flush: true,
    );
  }
}

const _piperModelAsset = 'assets/piper/voice.onnx';
const _piperConfigAsset = 'assets/piper/voice.onnx.json';
const _piperModelFile = 'voice.onnx';
const _piperConfigFile = 'voice.onnx.json';
const _forcePiperOnAndroid = true;
