import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../../../core/di/injection_container.dart';
import '../controllers/breathing_controller.dart';

class MoodSelectionPage extends StatelessWidget {
  const MoodSelectionPage({super.key});

  static const _moods = [
    'Calm',
    'Neutral',
    'Stressed',
    'Anxious',
  ];

  @override
  Widget build(BuildContext context) {
    final controller = getIt<BreathingController>();
    return Scaffold(
      appBar: AppBar(title: const Text('Select Goal')),
      body: Watch(
        (context) => ListView.separated(
          padding: const EdgeInsets.all(24),
          itemCount: _moods.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final mood = _moods[index];
            return ListTile(
              title: Text(mood),
              trailing: controller.options.value.mood == mood
                  ? const Icon(Icons.check)
                  : null,
              onTap: () {
                controller.updateMood(mood);
                Navigator.of(context).pop();
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
