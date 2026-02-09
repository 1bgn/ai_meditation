import 'package:flutter/material.dart';

import '../../domain/entities/meditation_recommendation.dart';

class RecommendationCard extends StatelessWidget {
  const RecommendationCard({
    super.key,
    required this.recommendation,
  });

  final MeditationRecommendation recommendation;

  @override
  Widget build(BuildContext context) => Container(
        width: 180,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              recommendation.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 6),
            Text(
              recommendation.subtitle,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const Spacer(),
            Text('${recommendation.durationMinutes} min'),
          ],
        ),
      );
}
