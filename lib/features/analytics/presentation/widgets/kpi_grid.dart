import 'package:flutter/material.dart';

import '../../domain/entities/analytics_data.dart';
import 'kpi_card.dart';

class AnalyticsKpiGrid extends StatelessWidget {
  final CookingAnalytics analytics;

  const AnalyticsKpiGrid({super.key, required this.analytics});

  @override
  Widget build(BuildContext context) {
    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.3,
      ),
      children: [
        AnalyticsKpiCard(
          title: 'Added to Cooking',
          value: analytics.totalAddedToCooking.toString(),
          icon: Icons.restaurant_menu,
        ),
        AnalyticsKpiCard(
          title: 'Added This Week',
          value: analytics.addedThisWeek.toString(),
          icon: Icons.calendar_today,
        ),
        AnalyticsKpiCard(
          title: 'Top Cuisine',
          value: analytics.topCuisine,
          icon: Icons.local_fire_department,
        ),
        AnalyticsKpiCard(
          title: 'Avg Cook Time',
          value: '${analytics.averageCookingTime.toStringAsFixed(0)} min',
          icon: Icons.timer,
        ),
      ],
    );
  }
}
