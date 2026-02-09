import 'package:flutter/material.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

class AiMeditationApp extends StatelessWidget {
  const AiMeditationApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        title: 'AI Meditation',
        theme: AppTheme.light(),
        routerConfig: AppRouter.router,
      );
}
