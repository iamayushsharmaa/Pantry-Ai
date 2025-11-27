import 'package:flutter/material.dart';

class MissingIngredientsHeader extends StatelessWidget {
  final ColorScheme colorScheme;

  const MissingIngredientsHeader({super.key, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Icon(Icons.shopping_cart_outlined, color: Colors.redAccent, size: 22),
        SizedBox(width: 8),
        Text(
          "Missing Ingredients",
          style: TextStyle(
            fontSize: 20,
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
