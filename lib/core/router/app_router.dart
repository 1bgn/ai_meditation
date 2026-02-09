import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/breathing/presentation/pages/breathing_page.dart';
import '../../features/breathing/presentation/pages/'
    'duration_selection_page.dart';
import '../../features/breathing/presentation/pages/breathing_session_page.dart';
import '../../features/breathing/presentation/pages/mood_selection_page.dart';
import '../../features/daily_routine/presentation/pages/'
    'daily_routine_page.dart';
import '../../features/generation/presentation/pages/'
    'background_sound_selection_page.dart';
import '../../features/generation/presentation/pages/'
    'duration_selection_page.dart';
import '../../features/generation/presentation/pages/generation_page.dart';
import '../../features/generation/presentation/pages/goal_selection_page.dart';
import '../../features/generation/presentation/pages/meditation_player_page.dart';
import '../../features/generation/presentation/pages/'
    'voice_style_selection_page.dart';
import '../../features/history/presentation/pages/history_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/paywall/presentation/pages/paywall_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';

class AppRoutes {
  static const splash = '/';
  static const onboarding = '/onboarding';
  static const home = '/home';
  static const generation = '/generation';
  static const generationGoal = '/generation/goal';
  static const generationDuration = '/generation/duration';
  static const generationVoice = '/generation/voice';
  static const generationBackground = '/generation/background';
  static const player = '/player';
  static const breathing = '/breathing';
  static const breathingMood = '/breathing/mood';
  static const breathingDuration = '/breathing/duration';
  static const breathingSession = '/breathing/session';
  static const dailyRoutine = '/daily';
  static const history = '/history';
  static const paywall = '/paywall';
}

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: AppRoutes.generation,
        builder: (context, state) => const GenerationPage(),
      ),
      GoRoute(
        path: AppRoutes.generationGoal,
        builder: (context, state) => const GoalSelectionPage(),
      ),
      GoRoute(
        path: AppRoutes.generationDuration,
        builder: (context, state) => const GenerationDurationSelectionPage(),
      ),
      GoRoute(
        path: AppRoutes.generationVoice,
        builder: (context, state) => const VoiceStyleSelectionPage(),
      ),
      GoRoute(
        path: AppRoutes.generationBackground,
        builder: (context, state) => const BackgroundSoundSelectionPage(),
      ),
      GoRoute(
        path: AppRoutes.player,
        builder: (context, state) {
          final args = state.extra;
          if (args is! MeditationPlayerArgs) {
            return const _RouteErrorPage(
              message: 'Missing player arguments.',
            );
          }
          return MeditationPlayerPage(args: args);
        },
      ),
      GoRoute(
        path: AppRoutes.breathing,
        builder: (context, state) => const BreathingPage(),
      ),
      GoRoute(
        path: AppRoutes.breathingMood,
        builder: (context, state) => const MoodSelectionPage(),
      ),
      GoRoute(
        path: AppRoutes.breathingDuration,
        builder: (context, state) => const BreathingDurationSelectionPage(),
      ),
      GoRoute(
        path: AppRoutes.breathingSession,
        builder: (context, state) => const BreathingSessionPage(),
      ),
      GoRoute(
        path: AppRoutes.dailyRoutine,
        builder: (context, state) => const DailyRoutinePage(),
      ),
      GoRoute(
        path: AppRoutes.history,
        builder: (context, state) => const HistoryPage(),
      ),
      GoRoute(
        path: AppRoutes.paywall,
        builder: (context, state) => const PaywallPage(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: SelectableText.rich(
          TextSpan(
            text: state.error?.toString() ?? 'Unknown navigation error',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.red),
          ),
        ),
      ),
    ),
  );
}

class _RouteErrorPage extends StatelessWidget {
  const _RouteErrorPage({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: SelectableText.rich(
            TextSpan(
              text: message,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.red),
            ),
          ),
        ),
      );
}
