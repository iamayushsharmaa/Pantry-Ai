import 'package:flutter/material.dart';

class MissingIngredientsHeader extends StatelessWidget {
  final ColorScheme colorScheme;

  const MissingIngredientsHeader({super.key, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.warning_rounded, color: colorScheme.error, size: 20),
        const SizedBox(width: 8),
        Text(
          "Missing Ingredients",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: colorScheme.error,
          ),
        ),
      ],
    );
  }
}
