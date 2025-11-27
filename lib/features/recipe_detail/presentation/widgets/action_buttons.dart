import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  final ColorScheme colorScheme;
  final VoidCallback onStartCooking;
  final VoidCallback onMarkAsCooked;

  const ActionButtons({
    required this.colorScheme,
    required this.onStartCooking,
    required this.onMarkAsCooked,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: colorScheme.primary,
                  side: BorderSide(color: colorScheme.primary, width: 2),
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: onMarkAsCooked,
                icon: const Icon(Icons.check_circle_outline, size: 20),
                label: const Text(
                  "Mark Cooked",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 2,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: onStartCooking,
                icon: const Icon(Icons.play_arrow_rounded, size: 22),
                label: const Text(
                  "Start Cooking",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
