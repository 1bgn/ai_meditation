import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/router/app_router.dart';
import '../../domain/entities/breathing_options.dart';
import '../controllers/breathing_controller.dart';
import 'breathing_session_page.dart';

class BreathingPage extends StatefulWidget {
  const BreathingPage({super.key});

  @override
  State<BreathingPage> createState() => _BreathingPageState();
}

class _BreathingPageState extends State<BreathingPage> {
  late final BreathingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = getIt<BreathingController>();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Breathing Exercise')),
        body: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Watch(
              (context) => _BreathingOptionsSection(
                options: _controller.options.value,
              ),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () => context.push(AppRoutes.breathingSession),
              child: const Text('Start Session'),
            ),
          ],
        ),
      );
}

class _BreathingOptionsSection extends StatelessWidget {
  const _BreathingOptionsSection({required this.options});

  final BreathingOptions options;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          _BreathingOptionTile(
            title: 'Meditation Goal',
            value: options.mood,
            onTap: () => context.push(AppRoutes.breathingMood),
          ),
          const SizedBox(height: 12),
          _BreathingOptionTile(
            title: 'Duration',
            value: '${options.durationMinutes} min',
            onTap: () => context.push(AppRoutes.breathingDuration),
          ),
        ],
      );
}

class _BreathingOptionTile extends StatelessWidget {
  const _BreathingOptionTile({
    required this.title,
    required this.value,
    required this.onTap,
  });

  final String title;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => ListTile(
        onTap: onTap,
        title: Text(title),
        subtitle: Text(value),
        trailing: const Icon(Icons.chevron_right),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        tileColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      );
}
