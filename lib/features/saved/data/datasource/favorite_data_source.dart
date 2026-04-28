import 'package:pantry_ai/features/saved/data/model/favorite_model.dart';
import 'package:pantry_ai/shared/models/recipe/recipe.dart';
import 'package:pantry_ai/shared/models/recipe/recipe_snapshot_model.dart';

import '../../../../shared/models/recipe/recipe_model.dart';

abstract class FavoriteRemoteDataSource {
  Future<void> addToFavorites(Recipe recipe);

  Future<void> removeFromFavorites(String recipeId);

  Future<bool> isFavorite(String recipeId);

  Stream<List<FavoriteRecipeModel>> getFavoritesStream();

  Future<List<FavoriteRecipeModel>> getFavoritesOnce();

}
