import 'package:flutter/material.dart';

import '../../../../core/utils/recipe_image_helper.dart';
import '../../../../shared/models/recipe/recipe.dart';
import 'gradient_placeholder.dart';

class CookingItem extends StatelessWidget {
  final Recipe recipe;
  final ColorScheme colorScheme;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  const CookingItem({
    required this.recipe,
    required this.colorScheme,
    required this.onTap,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: colorScheme.outline.withOpacity(0.1)),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withOpacity(0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 48,
                height: 48,
                child: (recipe.imageUrl != null && recipe.imageUrl!.isNotEmpty)
                    ? Image.network(
                        recipe.imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => GradientPlaceholder(
                          color: recipeColorFromTitle(recipe.title),
                        ),
                      )
                    : GradientPlaceholder(
                        color: recipeColorFromTitle(recipe.title),
                      ),
              ),
            ),
            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '${recipe.cookingTime} min · ${recipe.cuisine}',
                    style: TextStyle(
                      fontSize: 12,
                      color: colorScheme.onSurface.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ),

            GestureDetector(
              onTap: onRemove,
              child: Icon(
                Icons.check_circle_rounded,
                color: colorScheme.primary,
                size: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
