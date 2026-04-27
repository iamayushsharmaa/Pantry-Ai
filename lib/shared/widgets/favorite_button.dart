import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pantry_ai/shared/models/recipe/recipe_snapshot_model.dart';

import '../../core/utils/show_snackbar.dart';
import '../../features/saved/presentation/bloc/favourite_bloc/favorites_bloc.dart';
import '../../l10n/app_localizations.dart';

class FavoriteAppBarButton extends StatelessWidget {
  final RecipeSnapshot recipe;
  final ColorScheme cs;

  const FavoriteAppBarButton({
    required this.recipe,
    required this.cs,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocSelector<FavoritesBloc, FavoritesState, bool>(
      selector: (state) => state.favoriteIds.contains(recipe.id),
      builder: (context, isFavorite) {
        return GestureDetector(
          onTap: () {
            context.read<FavoritesBloc>().add(ToggleFavoriteEvent(recipe));
            showSnackBar(
              context,
              isFavorite ? l10n.remove_from_favorites : l10n.added_to_favorites,
              cs,
            );
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: isFavorite
                  ? Colors.red.withOpacity(0.12)
                  : cs.surface.withOpacity(0.92),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: cs.shadow.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              isFavorite
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
              color: isFavorite ? Colors.red : cs.onSurface,
              size: 20,
            ),
          ),
        );
      },
    );
  }
}
