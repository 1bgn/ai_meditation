import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../../../core/di/injection_container.dart';
import '../controllers/generation_controller.dart';

class GoalSelectionPage extends StatelessWidget {
  const GoalSelectionPage({super.key});

  static const _goals = [
    'Relax',
    'Focus',
    'Sleep',
    'Stress Relief',
  ];

  @override
  Widget build(BuildContext context) {
    final controller = getIt<GenerationController>();
    return Scaffold(
      appBar: AppBar(title: const Text('Select Goal')),
      body: SignalBuilder(
        signal: controller.options,
        builder: (context, value, child) => ListView.separated(
          padding: const EdgeInsets.all(24),
          itemCount: _goals.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final goal = _goals[index];
            return ListTile(
              title: Text(goal),
              trailing: value.goal == goal
                  ? const Icon(Icons.check)
                  : null,
              onTap: () async {
                await controller.updateGoal(goal);
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              tileColor:
                  Theme.of(context).colorScheme.surfaceContainerHighest,
            );
          },
        ),
      ),
    );
  }
}
