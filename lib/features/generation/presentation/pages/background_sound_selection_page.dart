import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../../../core/di/injection_container.dart';
import '../controllers/generation_controller.dart';

class BackgroundSoundSelectionPage extends StatelessWidget {
  const BackgroundSoundSelectionPage({super.key});

  static const _sounds = [
    'Ocean',
    'Rain',
    'Forest',
    'Silence',
  ];

  @override
  Widget build(BuildContext context) {
    final controller = getIt<GenerationController>();
    return Scaffold(
      appBar: AppBar(title: const Text('Select Background Sound')),
      body: SignalBuilder(
        signal: controller.options,
        builder: (context, value, child) => ListView.separated(
          padding: const EdgeInsets.all(24),
          itemCount: _sounds.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final sound = _sounds[index];
            return ListTile(
              title: Text(sound),
              trailing: value.backgroundSound == sound
                  ? const Icon(Icons.check)
                  : null,
              onTap: () async {
                await controller.updateBackgroundSound(sound);
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
