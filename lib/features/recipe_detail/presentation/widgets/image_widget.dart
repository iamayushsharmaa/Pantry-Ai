import 'package:flutter/material.dart';

import '../../../../core/utils/recipe_image_helper.dart';
import '../../../../shared/models/recipe/recipe.dart';

class ImageWidget extends StatelessWidget {
  final Recipe recipe;
  final ColorScheme cs;

  const ImageWidget({required this.recipe, required this.cs});

  @override
  Widget build(BuildContext context) {
    final color = recipeColorFromTitle(recipe.title);

    Widget imageChild;

    if (recipe.imageUrl != null && recipe.imageUrl!.isNotEmpty) {
      imageChild = Image.network(
        recipe.imageUrl!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: (_, __, ___) => _placeholder(color),
      );
    } else {
      imageChild = _placeholder(color);
    }

    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
          child: AspectRatio(aspectRatio: 16 / 10, child: imageChild),
        ),
        // Fade overlay at bottom
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, cs.surface.withOpacity(0.85)],
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _placeholder(Color color) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color, color.withOpacity(0.7)],
        ),
      ),
      child: Center(
        child: Icon(
          Icons.restaurant_menu_rounded,
          color: Colors.white.withOpacity(0.6),
          size: 64,
        ),
      ),
    );
  }
}
