import 'package:injectable/injectable.dart';

import '../../domain/entities/generation_options.dart';
import '../../domain/repositories/generation_repository.dart';
import '../../../../core/network/api_keys.dart';
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
  );

  final GenerationLocalDatasource _local;
  final OpenRouterRemoteDatasource _openRouter;
  final ElevenLabsRemoteDatasource _elevenLabs;

  @override
  GenerationOptions? getOptions() => _local.getOptions();

  @override
  Future<void> saveOptions(GenerationOptions options) =>
      _local.saveOptions(options);

  @override
  Future<void> generate(GenerationOptions options) async {
    ApiKeys.assertConfigured();
    final script = await _generateScript(options);
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

const _openRouterModel = 'google/gemma-3n-e2b-it:free';
const _voiceId = 'nPczCjzI2devNBz1zQrb';
const _voiceModelId = 'eleven_multilingual_v2';
