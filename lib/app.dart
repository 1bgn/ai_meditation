import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

class AiMeditationApp extends StatefulWidget {
  const AiMeditationApp({super.key});

  @override
  State<AiMeditationApp> createState() => _AiMeditationAppState();
}

class _AiMeditationAppState extends State<AiMeditationApp> {
  late final GoRouter _router = AppRouter.create();

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        title: 'AI Meditation',
        theme: AppTheme.light(),
        routerConfig: _router,
      );
}
