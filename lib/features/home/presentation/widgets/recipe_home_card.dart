import 'package:flutter/material.dart';

import '../../../../core/utils/recipe_image_helper.dart';

class RecipeHomeCard extends StatelessWidget {
  final ColorScheme colorScheme;
  final String title;
  final String cookTime;
  final int difficulty;
  final String? imageUrl;
  final VoidCallback onTap;

  const RecipeHomeCard({
    super.key,
    required this.colorScheme,
    required this.title,
    required this.cookTime,
    required this.difficulty,
    this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 160,
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: colorScheme.outline.withOpacity(0.1)),
            boxShadow: [
              BoxShadow(
                color: colorScheme.shadow.withOpacity(0.05),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ✅ Image with real cutout — no overflow
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(14),
                ),
                child: SizedBox(
                  height: 110,
                  width: double.infinity,
                  child: CardImage(
                    imageUrl: imageUrl,
                    title: title,
                    colorScheme: colorScheme,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          size: 12,
                          color: colorScheme.onSurface.withOpacity(0.45),
                        ),
                        const SizedBox(width: 3),
                        Text(
                          cookTime,
                          style: TextStyle(
                            fontSize: 11,
                            color: colorScheme.onSurface.withOpacity(0.5),
                          ),
                        ),
                        const Spacer(),
                        ...List.generate(
                          5,
                          (i) => Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: Container(
                              width: 5,
                              height: 5,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: i < difficulty
                                    ? colorScheme.primary
                                    : colorScheme.onSurface.withOpacity(0.15),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardImage extends StatelessWidget {
  final String? imageUrl;
  final String title;
  final ColorScheme colorScheme;

  const CardImage({
    required this.imageUrl,
    required this.title,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return Image.network(
        imageUrl!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        loadingBuilder: (_, child, progress) {
          if (progress == null) return child;
          return Placeholder(title: title);
        },
        errorBuilder: (_, __, ___) => Placeholder(title: title),
      );
    }
    return Placeholder(title: title);
  }
}

class Placeholder extends StatelessWidget {
  final String title;

  const Placeholder({required this.title});

  @override
  Widget build(BuildContext context) {
    final color = recipeColorFromTitle(title);
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
          color: Colors.white.withOpacity(0.7),
          size: 28,
        ),
      ),
    );
  }
}
