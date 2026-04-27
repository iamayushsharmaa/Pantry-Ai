import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_route_names.dart';
import '../../../../core/utils/recipe_image_helper.dart';
import '../../../../shared/models/saved_recipe/save_recipe.dart';
import '../../../saved/presentation/bloc/saved_bloc/saved_bloc.dart';

class CookingListWidget extends StatelessWidget {
  final ColorScheme colorScheme;

  const CookingListWidget({super.key, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SavedBloc, SavedState>(
      builder: (context, state) {
        final recipes = state.savedRecipes;

        if (recipes.isEmpty) return const SizedBox.shrink();

        return Column(
          children: recipes
              .take(5)
              .map(
                (r) => CookingListItem(
                  recipe: r,
                  colorScheme: colorScheme,
                  onTap: () => context.pushNamed(
                    AppRouteNames.recipeDetail,
                    extra: r.recipe.id,
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class CookingListItem extends StatelessWidget {
  final SavedRecipe recipe;
  final ColorScheme colorScheme;
  final VoidCallback onTap;

  const CookingListItem({
    super.key,
    required this.recipe,
    required this.colorScheme,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: colorScheme.outline.withOpacity(0.1)),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withOpacity(0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 48,
                height: 48,
                child:
                    (recipe.recipe.imageUrl != null &&
                        recipe.recipe.imageUrl!.isNotEmpty)
                    ? Image.network(
                        recipe.recipe.imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            Placeholder(title: recipe.recipe.title),
                      )
                    : Placeholder(title: recipe.recipe.title),
              ),
            ),
            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.recipe.title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '${recipe.recipe.cookingTime} min · ${recipe.recipe.cuisine}',
                    style: TextStyle(
                      fontSize: 12,
                      color: colorScheme.onSurface.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ),

            GestureDetector(
              onTap: () => context.read<SavedBloc>().add(
                ToggleSavedEvent(recipe.recipe),
              ),
              child: Icon(
                Icons.check_circle_rounded,
                color: colorScheme.primary,
                size: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Placeholder extends StatelessWidget {
  final String title;

  const Placeholder({required this.title});

  @override
  Widget build(BuildContext context) {
    final color = recipeColorFromTitle(title);
    return Container(
      color: color,
      child: Center(
        child: Icon(
          Icons.restaurant_menu_rounded,
          color: Colors.white.withOpacity(0.8),
          size: 20,
        ),
      ),
    );
  }
}
