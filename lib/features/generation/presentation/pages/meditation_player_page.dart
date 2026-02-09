import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../shared/widgets/feature_error_widget.dart';
import '../controllers/meditation_player_controller.dart';

class MeditationPlayerArgs {
  const MeditationPlayerArgs({
    required this.title,
    required this.script,
    required this.durationMinutes,
    required this.voiceStyle,
    required this.backgroundSound,
    this.preloadedSource,
  });

  final String title;
  final String script;
  final int durationMinutes;
  final String voiceStyle;
  final String backgroundSound;
  final AudioSource? preloadedSource;
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.start(
        script: widget.args.script,
        voiceStyle: widget.args.voiceStyle,
        preloadedSource: widget.args.preloadedSource,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
              const SizedBox(height: 32),
              Watch(
                (context) => _controller.error.value == null
                    ? const SizedBox.shrink()
                    : FeatureErrorWidget(
                        error: _controller.error.value!,
                      ),
              ),
              const Spacer(),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () =>
                          _controller.seekBy(const Duration(seconds: -15)),
                      icon: const _SeekIcon(
                        icon: Icons.replay,
                        label: '-15',
                      ),
                    ),
                    const SizedBox(width: 24),
                    Watch(
                      (context) => IconButton(
                        onPressed: _controller.togglePlayPause,
                        icon: Icon(
                          _controller.isPlaying.value
                              ? Icons.pause_circle_filled
                              : Icons.play_circle_fill,
                          size: 56,
                        ),
                      ),
                    ),
                    const SizedBox(width: 24),
                    IconButton(
                      onPressed: () =>
                          _controller.seekBy(const Duration(seconds: 15)),
                      icon: const _SeekIcon(
                        icon: Icons.forward,
                        label: '+15',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      );
}

class _SeekIcon extends StatelessWidget {
  const _SeekIcon({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ],
      );
}
