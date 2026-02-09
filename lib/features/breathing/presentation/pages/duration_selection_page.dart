import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../../../core/di/injection_container.dart';
import '../controllers/breathing_controller.dart';

class BreathingDurationSelectionPage extends StatelessWidget {
  const BreathingDurationSelectionPage({super.key});

  static const _durations = [1, 3, 5, 10];

  @override
  Widget build(BuildContext context) {
    final controller = getIt<BreathingController>();
    return Scaffold(
      appBar: AppBar(title: const Text('Select Duration')),
      body: SignalBuilder(
        signal: controller.options,
        builder: (context, value, child) => ListView.separated(
          padding: const EdgeInsets.all(24),
          itemCount: _durations.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final duration = _durations[index];
            return ListTile(
              title: Text('$duration min'),
              trailing: value.durationMinutes == duration
                  ? const Icon(Icons.check)
                  : null,
              onTap: () {
                controller.updateDuration(duration);
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
