import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/save_recipe_entity.dart';

class RecipeInfo extends StatelessWidget {
  final SavedRecipe saved;

  const RecipeInfo({required this.saved});

  @override
  Widget build(BuildContext context) {
    final recipe = saved.recipe;
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          recipe.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 6),
        Text(
          '${recipe.cuisine} • ${recipe.cookingTime} ${l10n.min}',
          style: TextStyle(fontSize: 13, color: cs.onSurfaceVariant),
        ),
        const SizedBox(height: 8),
        if (saved.notes != null)
          Text(
            saved.notes!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 12, color: cs.primary),
          ),
      ],
    );
  }
}
