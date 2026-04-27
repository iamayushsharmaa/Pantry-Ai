import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failure.dart';
import '../../../../shared/models/recipe/recipe_snapshot_model.dart';
import '../entities/favorite_recipe_entity.dart';

abstract class FavoriteRepository {
  Future<Either<Failure, void>> addToFavorites(RecipeSnapshot recipe);

  Future<Either<Failure, void>> removeFromFavorites(String recipeId);

  Future<Either<Failure, bool>> isFavorite(String recipeId);

  Stream<Either<Failure, List<FavoriteRecipe>>> getFavoritesStream();

  Future<Either<Failure, List<FavoriteRecipe>>> getFavoritesOnce();
}
