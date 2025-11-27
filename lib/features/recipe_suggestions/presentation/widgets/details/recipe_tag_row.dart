import 'package:flutter/material.dart';

class RecipeTagsRow extends StatelessWidget {
  final String? cuisine;
  final List<String>? dietaryInfo;
  final ColorScheme colorScheme;

  const RecipeTagsRow({
    super.key,
    this.cuisine,
    this.dietaryInfo,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: [
        if (cuisine != null)
          RecipeTag(text: cuisine!, colorScheme: colorScheme),
        if (dietaryInfo != null)
          ...dietaryInfo!.map(
            (info) => RecipeTag(text: info, colorScheme: colorScheme),
          ),
      ],
    );
  }
}

class RecipeTag extends StatelessWidget {
  final String text;
  final ColorScheme colorScheme;

  const RecipeTag({super.key, required this.text, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: colorScheme.onSecondaryContainer,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
