import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/router/app_router.dart';
import '../controllers/home_controller.dart';
import '../widgets/recommendation_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeController _controller;

  @override
  void initState() {
    super.initState();
    _controller = getIt<HomeController>()..load();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          actions: [
            IconButton(
              onPressed: () => context.go(AppRoutes.history),
              icon: const Icon(Icons.history),
            ),
            IconButton(
              onPressed: () => context.go(AppRoutes.paywall),
              icon: const Icon(Icons.workspace_premium),
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Text(
              'Today',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            SignalBuilder(
              signal: _controller.lastMeditationTitle,
              builder: (context, value, child) => Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  value == null
                      ? 'No meditation yet. Try generating one.'
                      : 'Last meditation: $value',
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Quick Actions',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            _ActionButton(
              title: 'Generate Meditation',
              onPressed: () => context.go(AppRoutes.generation),
            ),
            const SizedBox(height: 12),
            _ActionButton(
              title: 'Breathing Exercise',
              onPressed: () => context.go(AppRoutes.breathing),
            ),
            const SizedBox(height: 12),
            _ActionButton(
              title: 'Daily Routine',
              onPressed: () => context.go(AppRoutes.dailyRoutine),
            ),
            const SizedBox(height: 24),
            Text(
              'Recommendations',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 160,
              child: SignalBuilder(
                signal: _controller.recommendations,
                builder: (context, value, child) => ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: value.length,
                  itemBuilder: (context, index) => RecommendationCard(
                    recommendation: value[index],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.title,
    required this.onPressed,
  });

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => FilledButton(
        onPressed: onPressed,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(title),
        ),
      );
}
