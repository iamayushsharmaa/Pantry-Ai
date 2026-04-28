import 'package:flutter/material.dart';

class AnalyticsKpiCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color? iconBg;

  const AnalyticsKpiCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.iconBg,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cs.outlineVariant.withOpacity(0.5), width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32, height: 32,
            decoration: BoxDecoration(
              color: iconBg ?? cs.primaryContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 16, color: cs.primary),
          ),
          const SizedBox(height: 10),
          Text(value,
            style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: cs.onSurface,
            ),
          ),
          const SizedBox(height: 2),
          Text(title,
            style: TextStyle(fontSize: 11, color: cs.onSurface.withOpacity(0.55)),
          ),
        ],
      ),
    );
  }
}