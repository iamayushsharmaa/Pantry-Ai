import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failure.dart';
import '../../../../shared/models/recipe/recipe_model.dart';
import '../../../recipe_suggestions/domain/enities/recipe_entity.dart';
import '../../domain/entities/favorite_recipe_entity.dart';
import '../../domain/repository/favorite_repository.dart';
import '../remote/favorite_data_source.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteRemoteDataSource remote;

  FavoriteRepositoryImpl(this.remote);

  @override
  Future<Either<Failure, void>> addToFavorites(Recipe recipe) async {
    try {
      await remote.addToFavorites(recipe as RecipeModel);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeFromFavorites(String recipeId) async {
    try {
      await remote.removeFromFavorites(recipeId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isFavorite(String recipeId) async {
    try {
      final result = await remote.isFavorite(recipeId);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Stream<Either<Failure, List<FavoriteRecipe>>> getFavoritesStream() {
    return remote
        .getFavoritesStream()
        .map((models) {
          final entities = models
              .map(
                (m) => FavoriteRecipe(
                  recipeId: m.id,
                  favoritedAt: DateTime.now(),
                  // you can store favoritedAt in snapshot if needed
                  title: m.title,
                  imageUrl: m.imageUrl,
                ),
              )
              .toList();
          return Right<Failure, List<FavoriteRecipe>>(entities);
        })
        .handleError(
          (e) => Left<Failure, List<FavoriteRecipe>>(ServerFailure("server")),
        );
  }
}
