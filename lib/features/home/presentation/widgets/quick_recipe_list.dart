import 'package:flutter/material.dart';
import 'package:pantry_ai/features/home/presentation/widgets/recipe_home_card.dart';

import '../../../../core/constant/constants.dart';
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

    // return SizedBox(
    //   height: 204,
    //   child: ListView.builder(
    //     scrollDirection: Axis.horizontal,
    //     physics: const BouncingScrollPhysics(),
    //     padding: EdgeInsets.zero,
    //     itemCount: 1,
    //     itemBuilder: (context, index) {
    //       final recipe = Constants.dummyQuickRecipes[index];
    //       return Padding(
    //         padding: EdgeInsets.only(
    //           right: index < Constants.dummyQuickRecipes.length - 1 ? 12 : 0,
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
