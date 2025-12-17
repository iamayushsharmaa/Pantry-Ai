import 'package:flutter/material.dart';
import 'package:pantry_ai/features/favorites/presentation/widgets/recipe_info.dart';
import 'package:pantry_ai/features/save_recipe/presentation/widgets/recipe_image.dart';

import '../../../../core/theme/colors.dart';
import '../../../../shared/models/recipe/recipe_snapshot_model.dart';

class FavoriteRecipeCard extends StatelessWidget {
  final RecipeSnapshot recipe;
  final VoidCallback onRemove;
  final VoidCallback onTap;

  const FavoriteRecipeCard({
    super.key,
    required this.recipe,
    required this.onRemove,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => onTap,
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
