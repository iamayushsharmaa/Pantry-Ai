import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../shared/models/recipe/recipe.dart';
import 'meta_chip.dart';

class RecipeInfo extends StatelessWidget {
  final Recipe recipe;

  const RecipeInfo({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
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
          recipe.cuisine,
          style: TextStyle(fontSize: 13, color: cs.onSurface.withOpacity(0.6)),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            MetaChip(
              icon: Icons.timer_outlined,
              label: '${recipe.cookingTime} ${l10n.min}',
            ),
            const SizedBox(width: 8),
            MetaChip(
              icon: Icons.local_fire_department_outlined,
              label: '${recipe.calories} ${l10n.cal}',
            ),
          ],
        ),
      ],
    );
  }
}
