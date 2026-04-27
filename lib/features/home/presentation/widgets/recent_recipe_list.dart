import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_route_names.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../recipe_suggestions/presentation/widgets/recipe_card_widget.dart';
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
          return const Padding(
            padding: EdgeInsets.only(top: 40),
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

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              final recipe = recipes[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: RecipeCard(
                  recipe: recipe,
                  colorScheme: colorScheme,
                  onTap: () => context.pushNamed(
                    AppRouteNames.recipeDetail,
                    extra: recipe.id,
                  ),
                ),
              );
            },
          );
        }

        if (state is HomeError) {
          return Center(
            child: Text(
              state.message,
              style: TextStyle(color: colorScheme.error, fontSize: 13),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
