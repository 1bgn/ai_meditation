import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/tts/tts_service.dart';
import '../../../../shared/widgets/feature_error_widget.dart';
import '../../domain/entities/generation_options.dart';
import '../controllers/generation_controller.dart';
import 'meditation_player_page.dart';
import '../widgets/option_tile.dart';

class GenerationPage extends StatefulWidget {
  const GenerationPage({super.key});

  @override
  State<GenerationPage> createState() => _GenerationPageState();
}

class _GenerationPageState extends State<GenerationPage> {
  late final GenerationController _controller;
  final _isPreparingAudio = signal(false);

  @override
  void initState() {
    super.initState();
    _controller = getIt<GenerationController>()..load();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Generate Meditation')),
        body: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Watch(
              (context) => _OptionsSection(
                options: _controller.options.value,
              ),
            ),
            const SizedBox(height: 16),
            Watch(
              (context) => _controller.error.value == null
                  ? const SizedBox.shrink()
                  : FeatureErrorWidget(
                      error: _controller.error.value!,
                    ),
            ),
            const SizedBox(height: 16),
            Watch(
              (context) => FilledButton(
                onPressed: _controller.isGenerating.value ||
                        _isPreparingAudio.value
                    ? null
                    : () async {
                        final script = await _controller.generate();
                        if (!context.mounted || script == null) {
                          return;
                        }
                        _isPreparingAudio.value = true;
                        try {
                          final source =
                              await getIt<TtsService>().buildAudioSource(
                            script,
                            language: _playerLanguage,
                            pitch: 1.0,
                            rate: 0.6,
                            voiceStyle: _controller.options.value.voiceStyle,
                          );
                          if (!context.mounted) {
                            return;
                          }
                          context.push(
                            AppRoutes.player,
                            extra: MeditationPlayerArgs(
                              title:
                                  '${_controller.options.value.goal} Meditation',
                              script: script,
                              durationMinutes:
                                  _controller.options.value.durationMinutes,
                              voiceStyle: _controller.options.value.voiceStyle,
                              backgroundSound:
                                  _controller.options.value.backgroundSound,
                              preloadedSource: source,
                            ),
                          );
                        } catch (e) {
                          _controller.error.value = e.toString();
                        } finally {
                          _isPreparingAudio.value = false;
                        }
                      },
                child: Text(
                  _controller.isGenerating.value
                      ? 'Generating...'
                      : _isPreparingAudio.value
                          ? 'Preparing audio...'
                          : 'Generate',
                ),
              ),
            ),
          ],
        ),
      );
}

const _playerLanguage = 'en-US';

class _OptionsSection extends StatelessWidget {
  const _OptionsSection({required this.options});

  final GenerationOptions options;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          OptionTile(
            title: 'Goal',
            value: options.goal,
            onTap: () => context.push(AppRoutes.generationGoal),
          ),
          const SizedBox(height: 12),
          OptionTile(
            title: 'Duration',
            value: '${options.durationMinutes} min',
            onTap: () => context.push(AppRoutes.generationDuration),
          ),
          const SizedBox(height: 12),
          OptionTile(
            title: 'Voice Style',
            value: options.voiceStyle,
            onTap: () => context.push(AppRoutes.generationVoice),
          ),
          const SizedBox(height: 12),
          OptionTile(
            title: 'Background Sound',
            value: options.backgroundSound,
            onTap: () => context.push(AppRoutes.generationBackground),
          ),
        ],
      );
}
