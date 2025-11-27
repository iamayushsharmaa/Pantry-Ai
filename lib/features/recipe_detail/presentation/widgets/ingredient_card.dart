import 'package:flutter/material.dart';

import '../../../../shared/models/recipe/recipe.dart';

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
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ingredient.isAvailable
              ? Colors.green.withOpacity(0.3)
              : colorScheme.outline.withOpacity(0.15),
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
                  : colorScheme.surfaceContainerHigh,
              shape: BoxShape.circle,
            ),
            child: Icon(
              ingredient.isAvailable
                  ? Icons.check_rounded
                  : Icons.circle_outlined,
              color: ingredient.isAvailable
                  ? Colors.green
                  : colorScheme.onSurface.withOpacity(0.5),
              size: 18,
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
                    fontSize: 15,
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
