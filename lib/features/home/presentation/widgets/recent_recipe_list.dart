import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pantry_ai/features/home/presentation/widgets/recipe_home_card.dart';

import '../../../../core/router/app_route_names.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/recent_bloc/home_bloc.dart';
import 'empty_state.dart';

class RecentRecipesList extends StatelessWidget {
  final ColorScheme colorScheme;

  const RecentRecipesList({super.key, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const SizedBox(
            height: 204,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is HomeEmpty) {
          return EmptyState(
            colorScheme: colorScheme,
            icon: Icons.restaurant_menu_rounded,
            message: l10n.no_recipes_generated_yet,
            actionText: l10n.scan_your_pantry_to_get_started,
          );
        }

        if (state is HomeLoaded) {
          final recipes = state.recipes;

          return SizedBox(
            height: 204,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                final recipe = recipes[index];

                return Padding(
                  padding: EdgeInsets.only(
                    right: index < recipes.length - 1 ? 12 : 0,
                  ),
                  child: RecipeHomeCard(
                    colorScheme: colorScheme,
                    title: recipe.title,
                    cookTime: '${recipe.cookingTime} min',
                    difficulty: recipe.difficulty.toString(),
                    imageUrl: recipe.imageUrl,
                    onTap: () {
                      context.pushNamed(
                        AppRouteNames.recipeDetail,
                        extra: recipe,
                      );
                    },
                  ),
                );
              },
            ),
          );
        }

        if (state is HomeError) {
          return Center(child: Text(state.message));
        }

        return const SizedBox.shrink();
      },
    );
  }
}
