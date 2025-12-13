import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/show_snackbar.dart';
import '../../features/favorites/presentation/bloc/favorites_bloc.dart';
import '../models/recipe/recipe.dart';

class FavoriteButton extends StatelessWidget {
  final Recipe recipe;

  const FavoriteButton({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return BlocSelector<FavoritesBloc, FavoritesState, bool>(
      selector: (state) => state.favoriteIds.contains(recipe.id),
      builder: (context, isFavorite) {
        return IconButton(
          icon: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: cs.surface.withOpacity(0.9),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isFavorite
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
              color: isFavorite ? Colors.red : cs.onSurface,
              size: 22,
            ),
          ),
          onPressed: () {
            context.read<FavoritesBloc>().add(ToggleFavoriteEvent(recipe));

            showSnackBar(
              context,
              isFavorite ? 'Removed from favorites' : 'Added to favorites ❤',
              cs,
            );
          },
        );
      },
    );
  }
}
