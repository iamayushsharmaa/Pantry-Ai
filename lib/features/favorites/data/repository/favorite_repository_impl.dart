import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failure.dart';
import '../../../../shared/models/recipe/recipe.dart';
import '../../../../shared/models/recipe/recipe_model.dart';
import '../../../auth/data/remote/auth_local_data_source.dart';
import '../../domain/entities/favorite_recipe_entity.dart';
import '../../domain/repository/favorite_repository.dart';
import '../remote/favorite_data_source.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteRemoteDataSource remote;
  final AuthLocalDataSource auth;

  FavoriteRepositoryImpl({required this.remote, required this.auth});

  @override
  Future<Either<Failure, void>> addToFavorites(Recipe recipe) async {
    try {
      await remote.addToFavorites(recipe as RecipeModel);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> removeFromFavorites(String recipeId) async {
    try {
      await remote.removeFromFavorites(recipeId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
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
        .map((favoriteModels) {
          final entities = favoriteModels
              .map(
                (model) => FavoriteRecipe(
                  userId: model.userId,
                  recipeId: model.recipeId,
                  favoritedAt: model.favoritedAt,
                  recipeSnapshot: model.recipeSnapshot,
                ),
              )
              .toList();
          return Right<Failure, List<FavoriteRecipe>>(entities);
        })
        .handleError(
          (_) => Left<Failure, List<FavoriteRecipe>>(ServerFailure()),
        );
  }

  @override
  Future<Either<Failure, List<FavoriteRecipe>>> getFavoritesOnce() async {
    try {
      final models = await remote.getFavoritesOnce();
      return Right(models.map((model) => model).toList());
    } catch (_) {
      return Left(ServerFailure());
    }
  }
}
