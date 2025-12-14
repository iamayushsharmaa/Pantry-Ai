import 'package:flutter/material.dart';

import '../../domain/entities/analytics_data.dart';

class AnalyticsInsightCard extends StatelessWidget {
  final CookingAnalytics analytics;

  const AnalyticsInsightCard({super.key, required this.analytics});

  @override
  Widget build(BuildContext context) {
    final percentage = (analytics.favoriteToCookingRatio * 100).toStringAsFixed(
      0,
    );

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
      ),
      child: Row(
        children: [
          const Icon(Icons.insights, size: 32),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '$percentage% of your favorite recipes were added to cooking.',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
