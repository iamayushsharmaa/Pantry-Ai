import 'package:flutter/material.dart';
import 'package:pantry_ai/l10n/app_localizations.dart';

class DifficultyUtils {
  static String getDifficultyLabel(int difficulty, AppLocalizations l10n) {
    switch (difficulty) {
      case 1:
        return "Very Easy";
      case 2:
        return l10n.easy;
      case 3:
        return l10n.medium;
      case 4:
        return l10n.hard;
      case 5:
        return l10n.hard; //expert
      default:
        return l10n.medium;
    }
  }

  static Color getDifficultyColor(String difficulty, ColorScheme colorScheme) {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return Colors.green;
      case 'medium':
        return Colors.orange;
      case 'hard':
        return Colors.red;
      default:
        return colorScheme.primary;
    }
  }
}
