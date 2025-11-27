import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/models/recipe/recipe.dart';
import '../../domain/entities/favorite_recipe_entity.dart';
import '../../domain/usecases/get_favorite_stream.dart';
import '../../domain/usecases/toggle_favorite.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final ToggleFavorite toggleFavorite;
  final GetFavoritesStream getFavoritesStream;
  StreamSubscription? _subscription;

  FavoritesBloc({
    required this.toggleFavorite,
    required this.getFavoritesStream,
  }) : super(FavoritesState.initial()) {
    on<ToggleFavoriteEvent>(_onToggleFavorite);
    on<LoadFavorites>(_onLoadFavorites);

    add(LoadFavorites());
  }

  void _onLoadFavorites(LoadFavorites event, Emitter<FavoritesState> emit) {
    _subscription?.cancel();
    _subscription = getFavoritesStream().listen((favorites) {
      final ids = favorites.map((f) => f.recipeId).toSet();
      emit(state.copyWith(favorites: favorites, favoriteIds: ids));
    });
  }

  Future<void> _onToggleFavorite(
    ToggleFavoriteEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    await toggleFavorite(event.recipe);
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
