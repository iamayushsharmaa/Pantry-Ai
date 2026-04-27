part of 'favorites_bloc.dart';

class FavoritesState {
  final List<FavoriteRecipe> favorites;
  final Set<String> favoriteIds;
  final bool isLoading;

  const FavoritesState({
    required this.favorites,
    required this.favoriteIds,
    this.isLoading = false,
  });

  factory FavoritesState.initial() =>
      const FavoritesState(favorites: [], favoriteIds: {});

  FavoritesState copyWith({
    List<FavoriteRecipe>? favorites,
    Set<String>? favoriteIds,
    bool? isLoading,
  }) {
    return FavoritesState(
      favorites: favorites ?? this.favorites,
      favoriteIds: favoriteIds ?? this.favoriteIds,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
