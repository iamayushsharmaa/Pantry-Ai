import 'package:flutter/material.dart';

class EmptyAnalyticsState extends StatelessWidget {
  const EmptyAnalyticsState({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.bar_chart_rounded,
            size: 72,
            color: cs.onSurface.withOpacity(0.3),
          ),
          const SizedBox(height: 16),
          Text(
            'No analytics yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: cs.onSurface,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Start cooking recipes to see insights',
            style: TextStyle(color: cs.onSurface.withOpacity(0.6)),
          ),
        ],
      ),
    );
  }
}
