import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pantry_ai/features/saved/presentation/widgets/saved_section_header.dart';

import '../../../../core/router/app_route_names.dart';
import '../../../../shared/models/saved_recipe/save_recipe.dart';
import '../bloc/saved_bloc/saved_bloc.dart';
import 'cooking_item_widget.dart';

class CookingListSection extends StatelessWidget {
  final List<SavedRecipe> recipes;
  final ColorScheme colorScheme;

  const CookingListSection({required this.recipes, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SavedSectionHeader(
          icon: Icons.restaurant_menu_rounded,
          iconColor: colorScheme.primary,
          title: 'Cooking List',
          count: recipes.length,
          colorScheme: colorScheme,
        ),
        const SizedBox(height: 12),

        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: recipes.length,
          itemBuilder: (context, index) {
            final saved = recipes[index];
            final r = saved.recipe;
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: CookingItem(
                recipe: r,
                colorScheme: colorScheme,
                onTap: () =>
                    context.pushNamed(AppRouteNames.recipeDetail, extra: r.id),
                onRemove: () =>
                    context.read<SavedBloc>().add(ToggleSavedEvent(r)),
              ),
            );
          },
        ),
      ],
    );
  }
}
