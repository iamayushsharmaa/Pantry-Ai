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
    final isAvailable = ingredient.isAvailable;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),

        border: Border(
          left: BorderSide(
            color: isAvailable
                ? colorScheme.primary
                : colorScheme.outline.withOpacity(0.5),
            width: 3,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isAvailable
                  ? colorScheme.primary
                  : colorScheme.onSurface.withOpacity(0.25),
            ),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Text(
              ingredient.name,
              style: TextStyle(
                color: colorScheme.onSurface,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          Text(
            "${ingredient.quantity} ${ingredient.unit}",
            style: TextStyle(
              color: colorScheme.onSurface.withOpacity(0.5),
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
