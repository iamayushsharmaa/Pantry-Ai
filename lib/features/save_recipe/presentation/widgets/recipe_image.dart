import 'package:flutter/material.dart';

class RecipeImage extends StatelessWidget {
  final String url;

  const RecipeImage(this.url, {super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
      child: Image.network(url, width: 100, height: 100, fit: BoxFit.cover),
    );
  }
}
