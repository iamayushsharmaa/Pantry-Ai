import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pantry_ai/features/saved/presentation/widgets/saved_section_header.dart';

import '../../../../core/router/app_route_names.dart';
import '../../domain/entities/favorite_recipe_entity.dart';
import '../bloc/favourite_bloc/favorites_bloc.dart';
import 'favourite_card_widget.dart';

class FavoritesSection extends StatelessWidget {
  final List<FavoriteRecipe> favorites;
  final ColorScheme colorScheme;

  const FavoritesSection({required this.favorites, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SavedSectionHeader(
          icon: Icons.favorite_rounded,
          iconColor: Colors.red,
          title: 'Favorites',
          count: favorites.length,
          colorScheme: colorScheme,
        ),
        const SizedBox(height: 12),

        SizedBox(
          height: 190,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            physics: const BouncingScrollPhysics(),
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final fav = favorites[index];
              final r = fav.recipe;
              return Padding(
                padding: EdgeInsets.only(
                  right: index < favorites.length - 1 ? 10 : 0,
                ),
                child: FavoriteCard(
                  recipe: r,
                  colorScheme: colorScheme,
                  onTap: () => context.pushNamed(
                    AppRouteNames.recipeDetail,
                    extra: r.id,
                  ),
                  onUnfavorite: () =>
                      context.read<FavoritesBloc>().add(ToggleFavoriteEvent(r)),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
