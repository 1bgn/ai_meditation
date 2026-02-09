import 'package:flutter/material.dart';

class FeatureErrorWidget extends StatelessWidget {
  const FeatureErrorWidget({
    super.key,
    required this.error,
  });

  final String error;

  @override
  Widget build(BuildContext context) => SelectableText.rich(
        TextSpan(
          text: error,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.red),
        ),
      );
}
