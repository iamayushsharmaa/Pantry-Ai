import 'package:flutter/material.dart';
import 'package:pantry_ai/features/recipe_suggestions/presentation/widgets/recipe_state_row.dart';
import 'package:pantry_ai/features/recipe_suggestions/presentation/widgets/recipe_tag_row.dart';

import '../../domain/enities/recipe_entity.dart';
import 'difficulty_indicator.dart';

class RecipeHeaderSectionWidget extends StatelessWidget {
  final Recipe recipe;
  final ColorScheme colorScheme;

  const RecipeHeaderSectionWidget({
    super.key,
    required this.recipe,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -20),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: colorScheme.background,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        ),
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              recipe.title,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: colorScheme.onBackground,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 16),

            // Stats Row (Rating, Time, Calories, Servings)
            RecipeStatsRow(recipe: recipe, colorScheme: colorScheme),
            const SizedBox(height: 16),

            // Difficulty Indicator
            RecipeDifficultyIndicator(
              difficulty: recipe.difficulty,
              colorScheme: colorScheme,
            ),

            // Tags (Cuisine + Dietary Info)
            if (recipe.cuisine != null || recipe.dietaryInfo != null) ...[
              const SizedBox(height: 12),
              RecipeTagsRow(
                cuisine: recipe.cuisine,
                dietaryInfo: recipe.dietaryInfo,
                colorScheme: colorScheme,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
