import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../../../core/di/injection_container.dart';
import '../../domain/entities/daily_routine_item.dart';
import '../controllers/daily_routine_controller.dart';

class DailyRoutinePage extends StatefulWidget {
  const DailyRoutinePage({super.key});

  @override
  State<DailyRoutinePage> createState() => _DailyRoutinePageState();
}

class _DailyRoutinePageState extends State<DailyRoutinePage> {
  late final DailyRoutineController _controller;

  @override
  void initState() {
    super.initState();
    _controller = getIt<DailyRoutineController>();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Daily Routine')),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Watch(
                (context) => _controller.currentRoutine.value == null
                    ? const Text('Generate a routine to get started.')
                    : _RoutineCard(
                        item: _controller.currentRoutine.value!,
                      ),
              ),
              const Spacer(),
              FilledButton(
                onPressed: _controller.generate,
                child: const Text('Generate Routine'),
              ),
            ],
          ),
        ),
      );
}

class _RoutineCard extends StatelessWidget {
  const _RoutineCard({required this.item});

  final DailyRoutineItem item;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(item.description),
            const SizedBox(height: 12),
            Text('${item.durationMinutes} min'),
          ],
        ),
      );
}
