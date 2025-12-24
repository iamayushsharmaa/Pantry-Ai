import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pantry_ai/features/home/presentation/widgets/recipe_home_card.dart';

import '../../../../core/router/app_route_names.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/quick_bloc/quick_recipe_bloc.dart';
import 'empty_state.dart';

class QuickRecipesList extends StatelessWidget {
  final ColorScheme colorScheme;

  const QuickRecipesList({super.key, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<QuickRecipesBloc, QuickRecipesState>(
      builder: (context, state) {
        if (state is QuickRecipesLoading) {
          return const SizedBox(
            height: 204,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is QuickRecipesEmpty) {
          return EmptyState(
            colorScheme: colorScheme,
            icon: Icons.flash_on_rounded,
            message: l10n.quick_recipes_coming_soon,
            actionText: l10n.generate_recipes_to_see_suggestions,
          );
        }

        // 3️⃣ Loaded
        if (state is QuickRecipesLoaded) {
          final recipes = state.recipes;

          return SizedBox(
            height: 204,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
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

        if (state is QuickRecipesError) {
          return EmptyState(
            colorScheme: colorScheme,
            icon: Icons.error_outline_rounded,
            message: l10n.failed_to_load_quick_recipes,
            actionText: l10n.try_again,
            onAction: () {
              context.read<QuickRecipesBloc>().add(const LoadQuickRecipes());
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
