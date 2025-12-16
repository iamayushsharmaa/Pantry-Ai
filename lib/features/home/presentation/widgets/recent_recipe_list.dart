import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import 'empty_state.dart';

class RecentRecipesList extends StatelessWidget {
  final ColorScheme colorScheme;

  const RecentRecipesList({required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    const hasRecipes = false;

    if (!hasRecipes) {
      return EmptyState(
        colorScheme: colorScheme,
        icon: Icons.restaurant_menu_rounded,
        message: l10n.no_recipes_generated_yet,
        actionText: l10n.scan_your_pantry_to_get_started,
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
