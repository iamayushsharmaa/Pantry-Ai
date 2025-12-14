
import 'package:flutter/material.dart';
import 'package:pantry_ai/features/analytics/presentation/widgets/range_selector.dart';

import '../../domain/entities/range.dart';

class AnalyticsHeader extends StatelessWidget {
  final AnalyticsRange range;

  const AnalyticsHeader({super.key, required this.range});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Your Cooking Insights',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          'Based on recipes you added to cooking',
          style: TextStyle(color: Colors.grey.shade600),
        ),
        const SizedBox(height: 12),
        AnalyticsRangeSelector(selected: range),
      ],
    );
  }
}
