import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pantry_ai/l10n/app_localizations.dart';

import '../../../../core/router/app_route_names.dart';
import '../bloc/favorites_bloc.dart';
import '../widgets/empty_fav_view.dart';
import '../widgets/favroite_recipe_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.favorites,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
        ),
      ),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.favorites.isEmpty) {
            return const EmptyFavoritesView();
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: state.favorites.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final fav = state.favorites[index];

              return FavoriteRecipeCard(
                recipe: fav.recipeSnapshot,
                onRemove: () {
                  context.read<FavoritesBloc>().add(
                    ToggleFavoriteEvent(fav.recipeSnapshot),
                  );
                },
                onTap: () => context.pushNamed(
                  AppRouteNames.recipeDetail,
                  extra: fav.recipeId,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
