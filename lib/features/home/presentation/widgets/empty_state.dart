import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final ColorScheme colorScheme;
  final IconData icon;
  final String message;
  final String actionText;
  final VoidCallback? onAction;

  const EmptyState({
    super.key,
    required this.colorScheme,
    required this.icon,
    required this.message,
    required this.actionText,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.outline.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            width: MediaQuery.sizeOf(context).width * 0.8,
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 32, color: colorScheme.onPrimaryContainer),
          ),
          const SizedBox(height: 12),
          Text(
            message,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 4),
          GestureDetector(
            onTap: onAction,
            child: Text(
              actionText,
              style: TextStyle(
                fontSize: 13,
                color: onAction == null
                    ? colorScheme.onSurface.withOpacity(0.4)
                    : colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
