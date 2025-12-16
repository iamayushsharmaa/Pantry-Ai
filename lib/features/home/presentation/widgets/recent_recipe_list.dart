import 'package:flutter/material.dart';
import 'package:pantry_ai/core/constant/constants.dart';
import 'package:pantry_ai/features/home/presentation/widgets/recipe_home_card.dart';

import 'empty_state.dart';

class RecentRecipesList extends StatelessWidget {
  final ColorScheme colorScheme;

  const RecentRecipesList({required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    const hasRecipes = false;

    if (!hasRecipes) {
      return EmptyState(
        colorScheme: colorScheme,
        icon: Icons.restaurant_menu_rounded,
        message: "No recipes generated yet",
          actionText: "Scan your pantry to get started",
      );
    }

    // return SizedBox(
    //   height: 204,
    //   child: ListView.builder(
    //     scrollDirection: Axis.horizontal,
    //     physics: const BouncingScrollPhysics(),
    //     padding: EdgeInsets.zero,
    //     itemCount: Constants.recentRecipes.length,
    //     itemBuilder: (context, index) {
    //       final recipe = Constants.recentRecipes[index];
    //       return Padding(
    //         padding: EdgeInsets.only(
    //           right: index < dummyRecipes.length - 1 ? 12 : 0,
    //         ),
    //         child: RecipeHomeCard(
    //           colorScheme: colorScheme,
    //           title: recipe['title'] as String,
    //           cookTime: recipe['cookTime'] as String,
    //           difficulty: recipe['difficulty'] as String,
    //           imageUrl: recipe['imageUrl'] as String?,
    //           onTap: () {
    //             print('Tapped on ${recipe['title']}');
    //           },
    //         ),
    //       );
    //     },
    //   ),
    // );
  }
}
