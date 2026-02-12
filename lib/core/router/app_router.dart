import 'package:ai_meditation/core/ui/glass_concave_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/breathing/presentation/pages/breathing_page.dart';
import '../../features/breathing/presentation/pages/duration_selection_page.dart';
import '../../features/breathing/presentation/pages/breathing_session_page.dart';
import '../../features/breathing/presentation/pages/mood_selection_page.dart';

import '../../features/daily_routine/presentation/pages/daily_routine_page.dart';

import '../../features/generation/presentation/pages/background_sound_selection_page.dart';
import '../../features/generation/presentation/pages/duration_selection_page.dart';
import '../../features/generation/presentation/pages/generation_page.dart';
import '../../features/generation/presentation/pages/goal_selection_page.dart';
import '../../features/generation/presentation/pages/meditation_player_page.dart';
import '../../features/generation/presentation/pages/routine_meditation_launcher.dart';
import '../../features/generation/presentation/pages/voice_style_selection_page.dart';

import '../../features/daily_routine/presentation/models/routine_meditation_args.dart';

import '../../features/history/presentation/pages/history_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/paywall/presentation/pages/paywall_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';

class AppRoutes {
  static const splash = '/';
  static const onboarding = '/onboarding';

  // Tabs
  static const home = '/home';
  static const history = '/history';

  // Other flows (как у тебя)
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
  static const paywall = '/paywall';
}

class AppRouter {
  static final _rootNavKey = GlobalKey<NavigatorState>(debugLabel: 'root');
  static final _homeTabNavKey = GlobalKey<NavigatorState>(
    debugLabel: 'homeTab',
  );
  static final _historyTabNavKey = GlobalKey<NavigatorState>(
    debugLabel: 'historyTab',
  );

  static GoRouter create() => GoRouter(
    navigatorKey: _rootNavKey,
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

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            _MainTabsShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            navigatorKey: _homeTabNavKey,
            routes: [
              GoRoute(
                path: AppRoutes.home,
                builder: (context, state) => const HomePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _historyTabNavKey,
            routes: [
              GoRoute(
                path: AppRoutes.history,
                builder: (context, state) => const HistoryPage(),
              ),
            ],
          ),
        ],
      ),

      // Остальные страницы оставляем как отдельные routes (без таббара).
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
          if (args is RoutineMeditationArgs) {
            return RoutineMeditationLauncher(args: args);
          }
          if (args is MeditationPlayerArgs) {
            return MeditationPlayerPage(args: args);
          }
          return const _RouteErrorPage(message: 'Missing player arguments.');
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
        path: AppRoutes.paywall,
        builder: (context, state) => const PaywallPage(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: SelectableText(
          state.error?.toString() ?? 'Unknown navigation error',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: Colors.red),
        ),
      ),
    ),
  );
}

class _MainTabsShell extends StatelessWidget {
  const _MainTabsShell({required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final delegate = GoRouter.of(context).routerDelegate; // Listenable

    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          Positioned.fill(child: navigationShell),

          Positioned(
            left: 16,
            right: 16,
            bottom: 12,
            child: ListenableBuilder(
              listenable: delegate,
              builder: (context, _) {
                return GlassConcaveTabBar(
                  currentIndex: navigationShell.currentIndex,
                  icons: const [
                    ('assets/images/home.svg', 'Home'),
                    ('assets/images/history.svg', 'History'),
                  ],
                  onChanged: (index) {
                    navigationShell.goBranch(
                      index,
                      initialLocation: index == navigationShell.currentIndex,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _RouteErrorPage extends StatelessWidget {
  const _RouteErrorPage({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: SelectableText(
        message,
        style: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(color: Colors.red),
      ),
    ),
  );
}
