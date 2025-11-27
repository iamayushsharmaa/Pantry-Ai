import 'package:flutter/material.dart';
import 'package:pantry_ai/features/recipe_detail/presentation/widgets/recipe_state_row.dart';
import 'package:pantry_ai/features/recipe_detail/presentation/widgets/recipe_tag_row.dart';

import '../../../../shared/models/recipe/recipe.dart';
import 'difficulty_indicator.dart';

class Header extends StatelessWidget {
  final Recipe recipe;
  final ColorScheme cs;
  final TextTheme textTheme;

  const Header({
    required this.recipe,
    required this.cs,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        Text(
          recipe.title,
          style: textTheme.headlineMedium?.copyWith(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: cs.onBackground,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 16),

        RecipeStatsRow(recipe: recipe, colorScheme: cs),
        const SizedBox(height: 16),

        RecipeDifficultyIndicator(
          difficulty: recipe.difficulty,
          colorScheme: cs,
        ),

        if (recipe.cuisine != null || recipe.dietaryInfo != null)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: RecipeTagsRow(
              cuisine: recipe.cuisine,
              dietaryInfo: recipe.dietaryInfo,
              colorScheme: cs,
            ),
          ),
      ],
    );
  }
}
