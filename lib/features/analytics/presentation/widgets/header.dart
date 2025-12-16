import 'package:flutter/material.dart';
import 'package:pantry_ai/features/analytics/presentation/widgets/range_selector.dart';

import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/range.dart';

class AnalyticsHeader extends StatelessWidget {
  final AnalyticsRange range;

  const AnalyticsHeader({super.key, required this.range});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.analytics_your_cooking_insights,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: cs.onSurface,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          l10n.analytics_based_on_cooking,
          style: TextStyle(color: cs.onSurface.withOpacity(0.6)),
        ),
        const SizedBox(height: 14),
        AnalyticsRangeSelector(selected: range),
      ],
    );
  }
}
