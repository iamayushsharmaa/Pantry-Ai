import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pantry_ai/core/router/app_route_names.dart';
import 'package:pantry_ai/features/save_recipe/presentation/widgets/recipe_image.dart';
import 'package:pantry_ai/features/save_recipe/presentation/widgets/recipe_info.dart';
import 'package:pantry_ai/features/save_recipe/presentation/widgets/unsave_button.dart';

import '../../domain/entities/save_recipe_entity.dart';

class SavedRecipeTile extends StatelessWidget {
  final SavedRecipe saved;

  const SavedRecipeTile({super.key, required this.saved});

  @override
  Widget build(BuildContext context) {
    final recipe = saved.recipe;
    final cs = Theme.of(context).colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        context.pushNamed(AppRouteNames.recipeDetail, extra: recipe);
      },
      child: Ink(
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: cs.shadow.withOpacity(0.05),
              blurRadius: 10,
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
                child: RecipeInfo(saved: saved),
              ),
            ),
            UnsaveButton(recipeId: recipe.id),
          ],
        ),
      ),
    );
  }
}
