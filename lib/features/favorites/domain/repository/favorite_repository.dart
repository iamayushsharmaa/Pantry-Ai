import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failure.dart';
import '../../../recipe_suggestions/domain/enities/recipe_entity.dart';
import '../entities/favorite_recipe_entity.dart';

abstract class FavoriteRepository {
  Future<Either<Failure, void>> addToFavorites(Recipe recipe);

  Future<Either<Failure, void>> removeFromFavorites(String recipeId);

  Future<Either<Failure, bool>> isFavorite(String recipeId);

  Stream<Either<Failure, List<FavoriteRecipe>>> getFavoritesStream();
}
