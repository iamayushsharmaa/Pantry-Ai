import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/show_snackbar.dart';
import '../../features/favorites/presentation/bloc/favorites_bloc.dart';
import '../models/recipe/recipe.dart';

class FavoriteButton extends StatefulWidget {
  final Recipe recipe;

  const FavoriteButton({required this.recipe, super.key});

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        bool isFavorite = state.favoriteIds.contains(widget.recipe.id);
        final cs = Theme.of(context).colorScheme;
        return IconButton(
          icon: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: cs.surface.withOpacity(0.9),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : cs.onSurface,
              size: 22,
            ),
          ),
          onPressed: () {
            setState(() => isFavorite = !isFavorite);
            showSnackBar(
              context,
              isFavorite ? 'Added to favorites ❤️' : 'Removed from favorites',
              cs,
            );
          },
        );
      },
    );
  }
}
