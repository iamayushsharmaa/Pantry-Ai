import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pantry_ai/core/router/app_route_names.dart';
import 'package:pantry_ai/features/favorites/presentation/widgets/recipe_info.dart';
import 'package:pantry_ai/features/save_recipe/presentation/widgets/recipe_image.dart';

import '../../../../core/theme/colors.dart';
import '../../../../shared/models/recipe/recipe.dart';

class FavoriteRecipeCard extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback onRemove;

  const FavoriteRecipeCard({
    super.key,
    required this.recipe,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => context.pushNamed(AppRouteNames.recipeDetail, extra: recipe),
      child: Ink(
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: cs.shadow.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            RecipeImage(recipe.imageUrl),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: RecipeInfo(recipe: recipe),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.favorite),
              color: AppColors.brand,
              onPressed: onRemove,
            ),
          ],
        ),
      ),
    );
  }
}
