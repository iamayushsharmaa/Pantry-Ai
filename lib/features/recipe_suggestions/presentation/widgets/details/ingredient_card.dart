import 'package:flutter/material.dart';

import '../../../domain/enities/ingredient_entity.dart';

class IngredientCard extends StatelessWidget {
  final Ingredient ingredient;
  final ColorScheme colorScheme;

  const IngredientCard({
    super.key,
    required this.ingredient,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ingredient.isAvailable
              ? Colors.green.withOpacity(0.3)
              : colorScheme.outline.withOpacity(0.2),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: ingredient.isAvailable
                  ? Colors.green.withOpacity(0.15)
                  : colorScheme.surfaceVariant,
              shape: BoxShape.circle,
            ),
            child: Icon(
              ingredient.isAvailable
                  ? Icons.check_rounded
                  : Icons.circle_outlined,
              color: ingredient.isAvailable
                  ? Colors.green
                  : colorScheme.onSurfaceVariant,
              size: 20,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ingredient.name,
                  style: TextStyle(
                    color: colorScheme.onSurface,
                    fontSize: 15.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (ingredient.quantity != null && ingredient.unit != null)
                  Text(
                    "${ingredient.quantity} ${ingredient.unit}",
                    style: TextStyle(
                      color: colorScheme.onSurface.withOpacity(0.6),
                      fontSize: 13,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
