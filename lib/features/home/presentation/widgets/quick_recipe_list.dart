import 'package:flutter/material.dart';
import 'package:pantry_ai/features/home/presentation/widgets/recipe_home_card.dart';

import 'empty_state.dart';

class QuickRecipesList extends StatelessWidget {
  final ColorScheme colorScheme;

  const QuickRecipesList({required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    final hasRecipes = false;

    if (!hasRecipes) {
      return EmptyState(
        colorScheme: colorScheme,
        icon: Icons.flash_on_rounded,
        message: "Quick recipes coming soon",
        actionText: "Generate recipes to see suggestions",
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
              title: "Quick Stir Fry",
              cookTime: "15 min",
              difficulty: "Easy",
              imageUrl: null,
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}
