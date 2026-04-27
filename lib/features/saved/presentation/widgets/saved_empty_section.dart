import 'package:flutter/material.dart';

class EmptySection extends StatelessWidget {
  final IconData icon;
  final String message;
  final String subtitle;
  final ColorScheme colorScheme;

  const EmptySection({
    required this.icon,
    required this.message,
    required this.subtitle,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Center(
        child: Column(
          children: [
            Icon(icon, size: 48, color: colorScheme.onSurface.withOpacity(0.2)),
            const SizedBox(height: 12),
            Text(
              message,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface.withOpacity(0.5),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: colorScheme.onSurface.withOpacity(0.35),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
