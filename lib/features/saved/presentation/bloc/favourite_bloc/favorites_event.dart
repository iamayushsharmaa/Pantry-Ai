part of 'favorites_bloc.dart';

sealed class FavoritesEvent {}

class ToggleFavoriteEvent extends FavoritesEvent {
  final RecipeSnapshot recipeSnapshot;

  ToggleFavoriteEvent(this.recipeSnapshot);
}

class LoadFavorites extends FavoritesEvent {}
