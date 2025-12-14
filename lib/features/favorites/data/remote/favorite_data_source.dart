import 'package:pantry_ai/features/favorites/data/models/favorite_model.dart';

import '../../../../shared/models/recipe/recipe_model.dart';

abstract class FavoriteRemoteDataSource {
  Future<void> addToFavorites(RecipeModel recipe);

  Future<void> removeFromFavorites(String recipeId);

  Future<bool> isFavorite(String recipeId);

  Stream<List<FavoriteRecipeModel>> getFavoritesStream();

  Future<List<FavoriteRecipeModel>> getFavoritesOnce();

}
