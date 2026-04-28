part of 'favorites_bloc.dart';

sealed class FavoritesEvent {}

class ToggleFavoriteEvent extends FavoritesEvent {
  final Recipe recipe;

  ToggleFavoriteEvent(this.recipe);
}

class LoadFavorites extends FavoritesEvent {}
