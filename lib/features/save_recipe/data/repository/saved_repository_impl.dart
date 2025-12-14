import 'package:fpdart/fpdart.dart';
import 'package:pantry_ai/features/auth/data/remote/auth_local_data_source.dart';

import '../../../../core/errors/failure.dart';
import '../../../../shared/models/recipe/recipe.dart';
import '../../domain/entities/save_recipe_entity.dart';
import '../../domain/repository/saved_repository.dart';
import '../datasource/saved_datasource.dart';
import '../model/saved_recipe_model.dart';

class SavedRepositoryImpl implements SavedRepository {
  final SavedRemoteDataSource remote;
  final AuthLocalDataSource auth;

  List<SavedRecipe>? _cache;

  SavedRepositoryImpl({required this.remote, required this.auth});

  @override
  Future<Either<Failure, void>> saveRecipe(
    Recipe recipe, {
    String? notes,
  }) async {
    try {
      final uid = auth.currentUserId;

      final model = SavedRecipeModel.fromRecipe(recipe: recipe, notes: notes);

      await remote.saveRecipe(uid: uid, recipe: model);

      return const Right(null);
    } catch (_) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> unsaveRecipe(String recipeId) async {
    try {
      final uid = auth.currentUserId;
      await remote.unsaveRecipe(uid: uid, recipeId: recipeId);
      return const Right(null);
    } catch (_) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> isSaved(String recipeId) async {
    try {
      final uid = auth.currentUserId;
      final saved = await remote.isSaved(uid: uid, recipeId: recipeId);
      return Right(saved);
    } catch (_) {
      return Left(ServerFailure());
    }
  }

  @override
  Stream<Either<Failure, List<SavedRecipe>>> getSavedStream() {
    final uid = auth.currentUserId;

    return remote
        .getSavedStream(uid)
        .map((models) {
          final entities = models.map((m) => m.toEntity()).toList();

          _cache = entities;

          return Right<Failure, List<SavedRecipe>>(entities);
        })
        .handleError((_) => Left<Failure, List<SavedRecipe>>(ServerFailure()));
  }

  List<SavedRecipe>? getCachedSavedRecipes() => _cache;

  @override
  Future<Either<Failure, void>> toggleSaved(
    Recipe recipe, {
    String? notes,
  }) async {
    final result = await isSaved(recipe.id);

    return result.fold(
      (failure) => Left(failure),
      (isSaved) =>
          isSaved ? unsaveRecipe(recipe.id) : saveRecipe(recipe, notes: notes),
    );
  }

  @override
  Future<Either<Failure, List<SavedRecipe>>> getSavedOnce() async {
    try {
      final models = await remote.getSavedOnce(auth.currentUserId);
      return Right(models.map((m) => m.toEntity()).toList());
    } catch (_) {
      return Left(ServerFailure());
    }
  }
}
