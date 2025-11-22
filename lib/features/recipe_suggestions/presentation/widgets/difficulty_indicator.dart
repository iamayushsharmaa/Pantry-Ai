import 'package:flutter/material.dart';

class RecipeDifficultyIndicator extends StatelessWidget {
  final int difficulty;
  final ColorScheme colorScheme;

  const RecipeDifficultyIndicator({
    super.key,
    required this.difficulty,
    required this.colorScheme,
  });

  String _getDifficultyLabel(int difficulty) {
    switch (difficulty) {
      case 1:
        return "Easy";
      case 2:
        return "Moderate";
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

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Difficulty: ",
          style: TextStyle(
            color: colorScheme.onBackground.withOpacity(0.7),
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        ...List.generate(5, (index) {
          return Icon(
            index < difficulty ? Icons.circle : Icons.circle_outlined,
            size: 12,
            color: index < difficulty
                ? colorScheme.primary
                : colorScheme.onBackground.withOpacity(0.3),
          );
        }),
        const SizedBox(width: 8),
        Text(
          _getDifficultyLabel(difficulty),
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
