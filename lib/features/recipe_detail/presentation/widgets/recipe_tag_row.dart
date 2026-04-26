import 'package:flutter/material.dart';

class RecipeTagsRow extends StatelessWidget {
  final String cuisine;
  final List<String> dietaryInfo;
  final ColorScheme colorScheme;

  const RecipeTagsRow({
    super.key,
    required this.cuisine,
    required this.dietaryInfo,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        if (cuisine.isNotEmpty)
          RecipeTag(text: cuisine, colorScheme: colorScheme, isPrimary: true),
        ...dietaryInfo.map(
          (info) =>
              RecipeTag(text: info, colorScheme: colorScheme, isPrimary: false),
        ),
      ],
    );
  }
}

class RecipeTag extends StatelessWidget {
  final String text;
  final ColorScheme colorScheme;
  final bool isPrimary;

  const RecipeTag({
    super.key,
    required this.text,
    required this.colorScheme,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: isPrimary
            ? colorScheme.primary.withOpacity(0.1)
            : colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isPrimary
              ? colorScheme.primary.withOpacity(0.3)
              : colorScheme.outline.withOpacity(0.15),
          width: 1,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: isPrimary
              ? colorScheme.primary
              : colorScheme.onSurface.withOpacity(0.7),
        ),
      ),
    );
  }
}
