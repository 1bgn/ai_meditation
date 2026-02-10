import 'package:flutter/material.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/network/api_keys.dart';
import '../../../../shared/widgets/feature_error_widget.dart';
import '../../domain/entities/generation_options.dart';
import '../../domain/usecases/generate_meditation.dart';
import 'meditation_player_page.dart';
import '../../../daily_routine/presentation/models/routine_meditation_args.dart';

class RoutineMeditationLauncher extends StatelessWidget {
  const RoutineMeditationLauncher({super.key, required this.args});

  final RoutineMeditationArgs args;

  Future<String> _buildScript() {
    final generator = getIt<GenerateMeditation>();
    ApiKeys.assertConfigured();
    final options = GenerationOptions(
      goal: args.goal,
      durationMinutes: args.durationMinutes,
      voiceStyle: args.voiceStyle,
      backgroundSound: args.backgroundSound,
    );
    return generator(options);
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<String>(
        future: _buildScript(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (snapshot.hasError) {
            final message = snapshot.error.toString();
            return Scaffold(
              body: Center(
                child: FeatureErrorWidget(error: message),
              ),
            );
          }
          final script = snapshot.data ?? '';
          final playerArgs = MeditationPlayerArgs(
            title: args.title,
            script: script,
            durationMinutes: args.durationMinutes,
            voiceStyle: args.voiceStyle,
            backgroundSound: args.backgroundSound,
          );
          return MeditationPlayerPage(args: playerArgs);
        },
      );
}
