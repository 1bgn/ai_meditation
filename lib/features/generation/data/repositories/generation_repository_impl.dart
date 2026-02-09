import 'package:injectable/injectable.dart';

import '../../domain/entities/generation_options.dart';
import '../../domain/repositories/generation_repository.dart';
import '../../../../core/network/api_keys.dart';
import '../../../../core/tts/tts_service.dart';
import '../datasources/eleven_labs_remote_datasource.dart';
import '../datasources/generation_local_datasource.dart';
import '../datasources/open_router_remote_datasource.dart';
import '../models/eleven_labs_request.dart';
import '../models/open_router_request.dart';

@LazySingleton(as: GenerationRepository)
class GenerationRepositoryImpl implements GenerationRepository {
  GenerationRepositoryImpl(
    this._local,
    this._openRouter,
    this._elevenLabs,
    this._ttsService,
  );

  final GenerationLocalDatasource _local;
  final OpenRouterRemoteDatasource _openRouter;
  final ElevenLabsRemoteDatasource _elevenLabs;
  final TtsService _ttsService;

  @override
  GenerationOptions? getOptions() => _local.getOptions();

  @override
  Future<void> saveOptions(GenerationOptions options) =>
      _local.saveOptions(options);

  @override
  Future<String> generate(GenerationOptions options) async {
    ApiKeys.assertConfigured();
    final script = await _generateScript(options);
    if (_useLocalTts) {
      final tone = _resolveTone(options.voiceStyle);
      await _ttsService.speak(
        script,
        language: _ttsLanguage,
        pitch: tone.pitch,
        rate: tone.rate,
      );
      return script;
    }
    await _elevenLabs.generateSpeech(
      _voiceId,
      ElevenLabsRequest(
        text: script,
        modelId: _voiceModelId,
        voiceSettings: const ElevenLabsVoiceSettings(
          stability: 0.5,
          similarityBoost: 0.5,
        ),
      ),
    );
    return script;
  }

  Future<String> _generateScript(GenerationOptions options) async {
    final request = OpenRouterRequest(
      model: _openRouterModel,
      messages: [
        OpenRouterMessage(
          role: 'user',
          content: _buildPrompt(options),
        ),
      ],
    );
    final response = await _openRouter.createChatCompletion(request);
    if (response.choices.isEmpty) {
      throw StateError('OpenRouter returned empty meditation script.');
    }
    final content = response.choices.first.message.content;
    if (content.trim().isEmpty) {
      throw StateError('OpenRouter returned empty meditation script.');
    }
    return content.trim();
  }

  String _buildPrompt(GenerationOptions options) =>
      'Создай ${options.durationMinutes}-минутную медитацию. '
      'Цель: ${options.goal}. '
      'Стиль голоса: ${options.voiceStyle}. '
      'Фоновый звук: ${options.backgroundSound}. '
      'Верни только текст для озвучки без заголовков и списков.';
}

const _useLocalTts = true;
const _openRouterModel = 'google/gemma-3n-e2b-it:free';
const _voiceId = 'nPczCjzI2devNBz1zQrb';
const _voiceModelId = 'eleven_multilingual_v2';
const _ttsLanguage = 'ru-RU';

_VoiceTone _resolveTone(String style) => switch (style.toLowerCase()) {
      'soft' => const _VoiceTone(pitch: 0.9, rate: 0.45),
      'neutral' => const _VoiceTone(pitch: 1.0, rate: 0.5),
      'deep' => const _VoiceTone(pitch: 0.8, rate: 0.42),
      'warm' => const _VoiceTone(pitch: 1.05, rate: 0.48),
      _ => const _VoiceTone(pitch: 1.0, rate: 0.5),
    };

class _VoiceTone {
  const _VoiceTone({
    required this.pitch,
    required this.rate,
  });

  final double pitch;
  final double rate;
}
