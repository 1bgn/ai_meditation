import 'package:injectable/injectable.dart';

import '../../domain/entities/generation_options.dart';
import '../../domain/repositories/generation_repository.dart';
import '../../../../core/network/api_keys.dart';
import '../datasources/generation_local_datasource.dart';
import '../datasources/open_router_remote_datasource.dart';
import '../models/open_router_request.dart';

@LazySingleton(as: GenerationRepository)
class GenerationRepositoryImpl implements GenerationRepository {
  GenerationRepositoryImpl(
    this._local,
    this._openRouter,
  );

  final GenerationLocalDatasource _local;
  final OpenRouterRemoteDatasource _openRouter;

  @override
  GenerationOptions? getOptions() => _local.getOptions();

  @override
  Future<void> saveOptions(GenerationOptions options) =>
      _local.saveOptions(options);

  @override
  Future<String> generate(GenerationOptions options) async {
    ApiKeys.assertConfigured();
    return _generateScript(options);
  }

  Future<String> _generateScript(GenerationOptions options) async {
    if (_useMockOpenRouter) {
      return _mockScript;
    }
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

  String _buildPrompt(GenerationOptions options) {
    final goalGuidance = _goalGuidance(options.goal);
    final voiceGuidance = _voiceStyleGuidance(options.voiceStyle);
    return 'Write a ${options.durationMinutes}-minute guided meditation '
        'script. Goal: ${options.goal}. '
        'Use these goal cues: $goalGuidance '
        'Voice style: ${options.voiceStyle}. '
        'Tone and pacing: $voiceGuidance '
        'Background sound: ${options.backgroundSound}. '
        'Return only the spoken text, no headings or lists.';
  }

  String _goalGuidance(String goal) {
    switch (goal.toLowerCase()) {
      case 'relax':
        return 'slow breathing, body scan, gentle reassurance';
      case 'focus':
        return 'clear anchors, light counts, minimal imagery';
      case 'sleep':
        return 'very slow pace, longer pauses, soothing imagery';
      case 'stress relief':
        return 'release tension, exhale cues, grounded sensations';
      default:
        return 'calm breath cues and light body awareness';
    }
  }

  String _voiceStyleGuidance(String style) {
    switch (style.toLowerCase()) {
      case 'soft':
        return 'soft, low volume, warm and airy';
      case 'neutral':
        return 'balanced, clear, steady pacing';
      case 'deep':
        return 'lower tone, slower cadence, grounded';
      case 'warm':
        return 'gentle warmth, friendly, reassuring';
      default:
        return 'calm, steady, and clear';
    }
  }
}

const _useMockOpenRouter = false;
const _openRouterModel = 'google/gemma-3n-e2b-it:free';
const _mockScript = '''
Close your eyes and take a slow breath in.

Feel the air fill your lungs, then exhale softly.
Let your shoulders drop with each breath.

Bring your attention to your body, from your forehead to your toes.
Release any tension you notice.

Inhale calm. Exhale what you no longer need.
Stay here for a few quiet moments.

When you feel ready, gently open your eyes.
''';
