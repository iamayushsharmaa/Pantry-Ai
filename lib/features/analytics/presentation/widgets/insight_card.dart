import 'package:flutter/material.dart';

import '../../domain/entities/analytics_data.dart';

class AnalyticsInsightCard extends StatelessWidget {
  final CookingAnalytics analytics;

  const AnalyticsInsightCard({super.key, required this.analytics});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final percentage = (analytics.favoriteToCookingRatio * 100).toStringAsFixed(
      0,
    );

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.primary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(Icons.insights, color: cs.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '$percentage% of favorite recipes were added to cooking.',
              style: TextStyle(
                fontSize: 15,
                color: cs.onSurface,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
