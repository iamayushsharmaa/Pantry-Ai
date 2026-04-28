import 'package:flutter/material.dart';

import '../../../../core/utils/recipe_image_helper.dart';
import '../../../../shared/models/recipe/recipe.dart';
import 'gradient_placeholder.dart';

class FavoriteCard extends StatelessWidget {
  final Recipe recipe;
  final ColorScheme colorScheme;
  final VoidCallback onTap;
  final VoidCallback onUnfavorite;

  const FavoriteCard({
    required this.recipe,
    required this.colorScheme,
    required this.onTap,
    required this.onUnfavorite,
  });

  @override
  Widget build(BuildContext context) {
    final color = recipeColorFromTitle(recipe.title);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160,
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: colorScheme.outline.withOpacity(0.1)),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(14),
              ),
              child: SizedBox(
                height: 110,
                width: double.infinity,
                child: (recipe.imageUrl != null && recipe.imageUrl!.isNotEmpty)
                    ? Image.network(
                        recipe.imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            GradientPlaceholder(color: color),
                      )
                    : GradientPlaceholder(color: color),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.title,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        size: 12,
                        color: colorScheme.onSurface.withOpacity(0.45),
                      ),
                      const SizedBox(width: 3),
                      Text(
                        '${recipe.cookingTime} min',
                        style: TextStyle(
                          fontSize: 11,
                          color: colorScheme.onSurface.withOpacity(0.5),
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: onUnfavorite,
                        child: Icon(
                          Icons.favorite_rounded,
                          size: 16,
                          color: Colors.red.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
