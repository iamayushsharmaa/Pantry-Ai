import 'package:flutter/material.dart';
import 'package:pantry_ai/core/utils/recipe_image_helper.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../shared/models/recipe/recipe.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final ColorScheme colorScheme;
  final VoidCallback onTap;

  const RecipeCard({
    super.key,
    required this.recipe,
    required this.colorScheme,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: colorScheme.outline.withOpacity(0.12)),
            boxShadow: [
              BoxShadow(
                color: colorScheme.shadow.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(14),
                  ),
                  child: SizedBox(
                    width: 90,
                    child: _RecipeImageWidget(
                      recipe: recipe,
                      colorScheme: colorScheme,
                    ),
                  ),
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          recipe.title,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: colorScheme.onSurface,
                            height: 1.2,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),

                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 7,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: colorScheme.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                recipe.cuisine,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: colorScheme.primary,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              Icons.star_rounded,
                              size: 13,
                              color: const Color(0xFFFBBF24),
                            ),
                            const SizedBox(width: 2),
                            Text(
                              recipe.rating.toStringAsFixed(1),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: colorScheme.onSurface.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),

                        Row(
                          children: [
                            Icon(
                              Icons.timer_outlined,
                              size: 13,
                              color: colorScheme.onSurface.withOpacity(0.45),
                            ),
                            const SizedBox(width: 3),
                            Text(
                              "${recipe.cookingTime} ${l10n.min}",
                              style: TextStyle(
                                fontSize: 12,
                                color: colorScheme.onSurface.withOpacity(0.55),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Icon(
                              Icons.local_fire_department_rounded,
                              size: 13,
                              color: colorScheme.onSurface.withOpacity(0.45),
                            ),
                            const SizedBox(width: 3),
                            Text(
                              "${recipe.calories} kcal",
                              style: TextStyle(
                                fontSize: 12,
                                color: colorScheme.onSurface.withOpacity(0.55),
                              ),
                            ),
                          ],
                        ),

                        if (recipe.missingIngredients.isNotEmpty) ...[
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Icon(
                                Icons.info_outline_rounded,
                                size: 12,
                                color: colorScheme.error.withOpacity(0.7),
                              ),
                              const SizedBox(width: 3),
                              Expanded(
                                child: Text(
                                  "${l10n.missing}: ${recipe.missingIngredients.take(2).join(', ')}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: colorScheme.error.withOpacity(0.8),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.chevron_right_rounded,
                    color: colorScheme.onSurface.withOpacity(0.3),
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RecipeImageWidget extends StatelessWidget {
  final Recipe recipe;
  final ColorScheme colorScheme;

  const _RecipeImageWidget({required this.recipe, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    if (recipe.imageUrl != null && recipe.imageUrl!.isNotEmpty) {
      return Image.network(
        recipe.imageUrl!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: (_, __, ___) => _placeholder(),
      );
    }
    return _placeholder();
  }

  Widget _placeholder() {
    final color = recipeColorFromTitle(recipe.title);
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color, color.withOpacity(0.75)],
        ),
      ),
      child: Center(
        child: Icon(
          Icons.restaurant_menu_rounded,
          color: Colors.white.withOpacity(0.85),
          size: 32,
        ),
      ),
    );
  }
}
