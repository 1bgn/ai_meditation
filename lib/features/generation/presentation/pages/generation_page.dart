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
            SignalBuilder(
              signal: _controller.options,
              builder: (context, value, child) => _OptionsSection(
                options: value,
              ),
            ),
            const SizedBox(height: 16),
            SignalBuilder(
              signal: _controller.error,
              builder: (context, value, child) =>
                  value == null ? const SizedBox() : FeatureErrorWidget(
                        error: value,
                      ),
            ),
            const SizedBox(height: 16),
            SignalBuilder(
              signal: _controller.isGenerating,
              builder: (context, value, child) => FilledButton(
                onPressed: value ? null : _controller.generate,
                child: Text(value ? 'Generating...' : 'Generate'),
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
