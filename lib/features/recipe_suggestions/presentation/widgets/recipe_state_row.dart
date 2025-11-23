import 'package:flutter/material.dart';

import '../../../../core/common/state_chip.dart';
import '../../domain/enities/recipe_entity.dart';

class RecipeStatsRow extends StatelessWidget {
  final Recipe recipe;
  final ColorScheme colorScheme;

  const RecipeStatsRow({
    super.key,
    required this.recipe,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        StatChip(
          icon: Icons.star_rounded,
          label: recipe.rating.toString(),
          color: Colors.amber,
          colorScheme: colorScheme,
        ),
        const SizedBox(width: 10),
        StatChip(
          icon: Icons.schedule_rounded,
          label: "${recipe.cookingTime} min",
          color: colorScheme.primary,
          colorScheme: colorScheme,
        ),
        const SizedBox(width: 10),
        StatChip(
          icon: Icons.local_fire_department_rounded,
          label: "${recipe.calories} cal",
          color: Colors.deepOrange,
          colorScheme: colorScheme,
        ),
        const SizedBox(width: 10),
        StatChip(
          icon: Icons.person_outline_rounded,
          label: "${recipe.servings}",
          color: Colors.teal,
          colorScheme: colorScheme,
        ),
      ],
    );
  }
}
