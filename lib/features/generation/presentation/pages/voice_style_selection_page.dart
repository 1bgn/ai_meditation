import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../../../core/di/injection_container.dart';
import '../controllers/generation_controller.dart';

class VoiceStyleSelectionPage extends StatelessWidget {
  const VoiceStyleSelectionPage({super.key});

  static const _styles = [
    'Soft',
    'Neutral',
    'Deep',
    'Warm',
  ];

  @override
  Widget build(BuildContext context) {
    final controller = getIt<GenerationController>();
    return Scaffold(
      appBar: AppBar(title: const Text('Select Voice Style')),
      body: SignalBuilder(
        signal: controller.options,
        builder: (context, value, child) => ListView.separated(
          padding: const EdgeInsets.all(24),
          itemCount: _styles.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final style = _styles[index];
            return ListTile(
              title: Text(style),
              trailing: value.voiceStyle == style
                  ? const Icon(Icons.check)
                  : null,
              onTap: () async {
                await controller.updateVoiceStyle(style);
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
