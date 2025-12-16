import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/analytics_data.dart';
import 'kpi_card.dart';

class AnalyticsKpiGrid extends StatelessWidget {
  final CookingAnalytics analytics;

  const AnalyticsKpiGrid({super.key, required this.analytics});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.35,
      ),
      children: [
        AnalyticsKpiCard(
          title: l10n.added_to_cooking,
          value: analytics.totalAddedToCooking.toString(),
          icon: Icons.restaurant_menu,
        ),
        AnalyticsKpiCard(
          title: l10n.this_week,
          value: analytics.addedThisWeek.toString(),
          icon: Icons.calendar_today,
        ),
        AnalyticsKpiCard(
          title: l10n.top_cuisine,
          value: analytics.topCuisine,
          icon: Icons.local_fire_department,
        ),
        AnalyticsKpiCard(
          title: l10n.avg_cook_time,
          value: '${analytics.averageCookingTime.toStringAsFixed(0)} min',
          icon: Icons.timer,
        ),
      ],
    );
  }
}
