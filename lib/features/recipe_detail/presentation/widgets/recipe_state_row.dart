import 'package:flutter/material.dart';

import '../../../../../core/common/state_chip.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/models/recipe/recipe.dart';

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
    final l10n = AppLocalizations.of(context)!;

    return Row(
      children: [
        StatChip(
          icon: Icons.star_rounded,
          label: recipe.rating.toStringAsFixed(1),
          iconColor: const Color(0xFFFBBF24),
          colorScheme: colorScheme,
        ),
        const SizedBox(width: 8),
        StatChip(
          icon: Icons.schedule_rounded,
          label: "${recipe.cookingTime} ${l10n.min}",
          iconColor: colorScheme.primary,
          colorScheme: colorScheme,
        ),
        const SizedBox(width: 8),
        StatChip(
          icon: Icons.local_fire_department_rounded,
          label: "${recipe.calories} ${l10n.cal}",
          iconColor: Colors.deepOrange,
          colorScheme: colorScheme,
        ),
        const SizedBox(width: 8),
        StatChip(
          icon: Icons.person_outline_rounded,
          label: "${recipe.servings} srv",
          iconColor: colorScheme.primary,
          colorScheme: colorScheme,
        ),
      ],
    );
  }
}