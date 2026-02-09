import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../../../core/di/injection_container.dart';
import '../controllers/meditation_player_controller.dart';

class MeditationPlayerArgs {
  const MeditationPlayerArgs({
    required this.title,
    required this.script,
    required this.durationMinutes,
    required this.voiceStyle,
    required this.backgroundSound,
  });

  final String title;
  final String script;
  final int durationMinutes;
  final String voiceStyle;
  final String backgroundSound;
}

class MeditationPlayerPage extends StatefulWidget {
  const MeditationPlayerPage({
    super.key,
    required this.args,
  });

  final MeditationPlayerArgs args;

  @override
  State<MeditationPlayerPage> createState() => _MeditationPlayerPageState();
}

class _MeditationPlayerPageState extends State<MeditationPlayerPage> {
  late final MeditationPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = getIt<MeditationPlayerController>();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Meditation Player'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.args.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                '${widget.args.durationMinutes} min · '
                '${widget.args.voiceStyle} · '
                '${widget.args.backgroundSound}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(widget.args.script),
                ),
              ),
              const SizedBox(height: 16),
              Watch(
                (context) => FilledButton(
                  onPressed:
                      _controller.isPlaying.value ? _controller.stop : null,
                  child: Text(
                    _controller.isPlaying.value ? 'Stop' : 'Stopped',
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
