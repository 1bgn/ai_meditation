import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../../../core/di/injection_container.dart';
import '../controllers/breathing_controller.dart';
import '../controllers/breathing_session_controller.dart';

class BreathingSessionPage extends StatefulWidget {
  const BreathingSessionPage({super.key});

  @override
  State<BreathingSessionPage> createState() => _BreathingSessionPageState();
}

class _BreathingSessionPageState extends State<BreathingSessionPage> {
  late final BreathingSessionController _controller;
  late final BreathingController _breathingController;

  @override
  void initState() {
    super.initState();
    _controller = getIt<BreathingSessionController>()..start();
    _breathingController = getIt<BreathingController>();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Breathing Session')),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Watch(
                (context) => Text(
                  _controller.isInhale.value ? 'Inhale' : 'Exhale',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: Center(
                  child: Watch(
                    (context) => AnimatedContainer(
                      duration: const Duration(milliseconds: 800),
                      width: _controller.isInhale.value ? 220 : 140,
                      height: _controller.isInhale.value ? 220 : 140,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Watch(
                (context) => Text(
                  '${_breathingController.options.value.mood} · '
                  '${_breathingController.options.value.durationMinutes} min',
                ),
              ),
              const SizedBox(height: 16),
              Watch(
                (context) => FilledButton(
                  onPressed:
                      _controller.isRunning.value ? _controller.stop : null,
                  child: Text(
                    _controller.isRunning.value ? 'Stop' : 'Stopped',
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
