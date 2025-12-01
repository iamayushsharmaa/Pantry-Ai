import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failure.dart';
import '../../../../shared/models/recipe/recipe.dart';
import '../../../../shared/models/recipe/recipe_model.dart';
import '../../../../shared/models/recipe/saved_recipe_model.dart';
import '../../domain/repository/saved_repository.dart';
import '../datasource/saved_datasource.dart';

class SavedRepositoryImpl implements SavedRepository {
  final SavedRemoteDataSource remote;

  SavedRepositoryImpl(this.remote);

  @override
  Future<Either<Failure, void>> saveRecipe(
    Recipe recipe, {
    String? notes,
  }) async {
    try {
      await remote.saveRecipe(recipe as RecipeModel, notes: notes);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> unsaveRecipe(String recipeId) async {
    try {
      await remote.unsaveRecipe(recipeId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> isSaved(String recipeId) async {
    try {
      return Right(await remote.isSaved(recipeId));
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Stream<Either<Failure, List<SavedRecipe>>> getSavedStream() {
    return remote
        .getSavedStream()
        .map((list) => Right<Failure, List<SavedRecipe>>(list))
        .handleError((_) => Left<Failure, List<SavedRecipe>>(ServerFailure()));
  }

  @override
  Future<Either<Failure, void>> toggleSaved(
    Recipe recipe, {
    String? notes,
  }) async {
    final currentlySaved = await isSaved(recipe.id);
    return currentlySaved.fold(
      (failure) => Left(failure),
      (isSaved) =>
          isSaved ? unsaveRecipe(recipe.id) : saveRecipe(recipe, notes: notes),
    );
  }
}