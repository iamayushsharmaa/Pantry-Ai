import 'package:flutter/material.dart';

class DifficultyUtils {
  static String getDifficultyLabel(int difficulty) {
    switch (difficulty) {
      case 1:
        return "Very Easy";
      case 2:
        return "Easy";
      case 3:
        return "Medium";
      case 4:
        return "Hard";
      case 5:
        return "Expert";
      default:
        return "Medium";
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
