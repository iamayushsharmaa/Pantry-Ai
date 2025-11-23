import 'package:flutter/material.dart';
import 'package:pantry_ai/features/home/presentation/widgets/recipe_home_card.dart';

import 'empty_state.dart';

class RecentRecipesList extends StatelessWidget {
  final ColorScheme colorScheme;

  const RecentRecipesList({required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    final hasRecipes = false;

    if (!hasRecipes) {
      return EmptyState(
        colorScheme: colorScheme,
        icon: Icons.restaurant_menu_rounded,
        message: "No recipes generated yet",
        actionText: "Scan your pantry to get started",
      );
    }
    return SizedBox(
      height: 240,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: index < 4 ? 12 : 0),
            child: RecipeHomeCard(
              colorScheme: colorScheme,
              title: "Pasta Carbonara",
              cookTime: "25 min",
              difficulty: "Medium",
              imageUrl: null,
              // Add your image
              onTap: () {
                // Navigate to recipe details
              },
            ),
          );
        },
      ),
    );
  }
}
