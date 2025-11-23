import 'package:flutter/material.dart';

class CategoryTitleScreenUtils {
  static String getCategoryTitle(String category) {
    switch (category) {
      case 'Recent':
        return 'Recently Generated';
      case 'Quick':
        return 'Quick & Easy';
      case 'Saved':
        return 'Saved Recipes';
      default:
        return 'All Recipes';
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

  static final recipes = List.generate(
    13,
    (index) => {
      'title': 'Recipe ${index + 1}',
      'cookTime': '${15 + index * 5} min',
      'difficulty': ['Easy', 'Medium', 'Hard'][index % 3],
      'cuisine': ['Italian', 'Asian', 'Mexican', 'Indian'][index % 4],
    },
  );
}
