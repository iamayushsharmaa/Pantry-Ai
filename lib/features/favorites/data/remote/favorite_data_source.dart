import '../../../../shared/models/recipe/recipe_model.dart';

abstract class FavoriteRemoteDataSource {
  Future<void> addToFavorites(RecipeModel recipe);

  Future<void> removeFromFavorites(String recipeId);

  Future<bool> isFavorite(String recipeId);

  Stream<List<RecipeModel>> getFavoritesStream();
}
