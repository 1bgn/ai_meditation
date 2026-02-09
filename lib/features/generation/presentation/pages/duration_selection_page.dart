import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../../../core/di/injection_container.dart';
import '../controllers/generation_controller.dart';

class GenerationDurationSelectionPage extends StatelessWidget {
  const GenerationDurationSelectionPage({super.key});

  static const _durations = [5, 10, 15, 20];

  @override
  Widget build(BuildContext context) {
    final controller = getIt<GenerationController>();
    return Scaffold(
      appBar: AppBar(title: const Text('Select Duration')),
      body: Watch(
        (context) => ListView.separated(
          padding: const EdgeInsets.all(24),
          itemCount: _durations.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final duration = _durations[index];
            return ListTile(
              title: Text('$duration min'),
              trailing: controller.options.value.durationMinutes == duration
                  ? const Icon(Icons.check)
                  : null,
              onTap: () async {
                await controller.updateDuration(duration);
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
