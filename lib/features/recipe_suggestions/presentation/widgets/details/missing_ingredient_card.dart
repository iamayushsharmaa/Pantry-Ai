import 'package:flutter/material.dart';

class MissingIngredientCard extends StatelessWidget {
  final String name;
  final ColorScheme colorScheme;

  const MissingIngredientCard({
    super.key,
    required this.name,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: colorScheme.errorContainer.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.error.withOpacity(0.3), width: 1),
      ),
      child: Row(
        children: [
          Icon(Icons.remove_circle_outline, color: colorScheme.error, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                color: colorScheme.onErrorContainer,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
