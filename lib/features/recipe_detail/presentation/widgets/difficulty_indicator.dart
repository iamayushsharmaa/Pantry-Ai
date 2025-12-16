import 'package:flutter/material.dart';
import 'package:pantry_ai/core/utils/difficulty_level.dart';

import '../../../../l10n/app_localizations.dart';

class RecipeDifficultyIndicator extends StatelessWidget {
  final int difficulty;
  final ColorScheme colorScheme;

  const RecipeDifficultyIndicator({
    super.key,
    required this.difficulty,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Row(
      children: [
        Text(
          "${l10n.difficulty}: ",
          style: TextStyle(
            color: colorScheme.onSurface.withOpacity(0.7),
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        ...List.generate(5, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1),
            child: Icon(
              index < difficulty ? Icons.circle : Icons.circle_outlined,
              size: 12,
              color: index < difficulty
                  ? colorScheme.primary
                  : colorScheme.onSurface.withOpacity(0.3),
            ),
          );
        }),
        const SizedBox(width: 8),
        Text(
          DifficultyUtils.getDifficultyLabel(difficulty),
          style: TextStyle(
            color: colorScheme.primary,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
