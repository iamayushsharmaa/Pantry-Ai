import 'package:pantry_ai/shared/models/recipe/recipe_snapshot_model.dart';

import '../repository/favorite_repository.dart';

class ToggleFavorite {
  final FavoriteRepository repo;

  ToggleFavorite(this.repo);

  Future<void> call(RecipeSnapshot recipeSnapshot) async {
    final isFav = await repo
        .isFavorite(recipeSnapshot.id)
        .then((e) => e.fold((_) => false, (v) => v));
    if (isFav) {
      await repo.removeFromFavorites(recipeSnapshot.id);
    } else {
      await repo.addToFavorites(recipeSnapshot);
    }
  }
}
