import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/router/app_router.dart';
import '../../../../shared/widgets/feature_error_widget.dart';
import '../../domain/entities/generation_options.dart';
import '../controllers/generation_controller.dart';
import '../widgets/option_tile.dart';

class GenerationPage extends StatefulWidget {
  const GenerationPage({super.key});

  @override
  State<GenerationPage> createState() => _GenerationPageState();
}

class _GenerationPageState extends State<GenerationPage> {
  late final GenerationController _controller;

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
                onPressed: _controller.isGenerating.value
                    ? null
                    : _controller.generate,
                child: Text(
                  _controller.isGenerating.value
                      ? 'Generating...'
                      : 'Generate',
                ),
              ),
            ),
          ],
        ),
      );
}

class _OptionsSection extends StatelessWidget {
  const _OptionsSection({required this.options});

  final GenerationOptions options;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          OptionTile(
            title: 'Goal',
            value: options.goal,
            onTap: () => context.go(AppRoutes.generationGoal),
          ),
          const SizedBox(height: 12),
          OptionTile(
            title: 'Duration',
            value: '${options.durationMinutes} min',
            onTap: () => context.go(AppRoutes.generationDuration),
          ),
          const SizedBox(height: 12),
          OptionTile(
            title: 'Voice Style',
            value: options.voiceStyle,
            onTap: () => context.go(AppRoutes.generationVoice),
          ),
          const SizedBox(height: 12),
          OptionTile(
            title: 'Background Sound',
            value: options.backgroundSound,
            onTap: () => context.go(AppRoutes.generationBackground),
          ),
        ],
      );
}
