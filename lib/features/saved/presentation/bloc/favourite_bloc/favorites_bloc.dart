import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pantry_ai/shared/models/recipe/recipe_snapshot_model.dart';

import '../../../domain/entities/favorite_recipe_entity.dart';
import '../../../domain/usecases/get_favorite_stream.dart';
import '../../../domain/usecases/toggle_favorite.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final ToggleFavorite toggleFavorite;
  final GetFavoritesStream getFavoritesStream;

  FavoritesBloc({
    required this.toggleFavorite,
    required this.getFavoritesStream,
  }) : super(FavoritesState.initial()) {
    on<LoadFavorites>(_onLoadFavorites);
    on<ToggleFavoriteEvent>(_onToggleFavorite);
    add(LoadFavorites());
  }

  Future<void> _onLoadFavorites(
    LoadFavorites event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    await emit.forEach<List<FavoriteRecipe>>(
      getFavoritesStream(),
      onData: (favorites) {
        final ids = favorites.map((f) => f.recipeId).toSet();
        return state.copyWith(
          favorites: favorites,
          favoriteIds: ids,
          isLoading: false,
        );
      },
      onError: (_, __) => state.copyWith(isLoading: false),
    );
  }

  Future<void> _onToggleFavorite(
    ToggleFavoriteEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    await toggleFavorite(event.recipeSnapshot);
  }
}
