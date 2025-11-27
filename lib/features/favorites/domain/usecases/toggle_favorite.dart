import '../../../recipe_suggestions/domain/enities/recipe_entity.dart';
import '../repository/favorite_repository.dart';

class ToggleFavorite {
  final FavoriteRepository repo;

  ToggleFavorite(this.repo);

  Future<void> call(Recipe recipe) async {
    final isFav = await repo
        .isFavorite(recipe.id)
        .then((e) => e.fold((_) => false, (v) => v));
    if (isFav) {
      await repo.removeFromFavorites(recipe.id);
    } else {
      await repo.addToFavorites(recipe);
    }
  }
}
