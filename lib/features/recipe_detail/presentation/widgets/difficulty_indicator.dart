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
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(5, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Icon(
                  index < difficulty ? Icons.circle : Icons.circle_outlined,
                  size: 10,
                  color: index < difficulty
                      ? colorScheme.primary
                      : colorScheme.onSurface.withOpacity(0.2),
                ),
              );
            }),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          DifficultyUtils.getDifficultyLabel(difficulty, l10n),
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
      ],
    );
  }
}
