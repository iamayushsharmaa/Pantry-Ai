import 'package:fpdart/fpdart.dart';
import 'package:pantry_ai/features/recipe_suggestions/data/datasource/local/recipe_local_datasource.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../../../shared/models/recipe/recipe.dart';
import '../../domain/repository/recipe_detail_repository.dart';

class RecipeDetailRepositoryImpl implements RecipeDetailRepository {
  final RecipeLocalDataSource local;

  RecipeDetailRepositoryImpl({required this.local});

  @override
  Future<Either<Failure, Recipe>> getRecipeById(String recipeId) async {
    try {
      final cached = await local.getCachedRecipes();
      final recipe = cached.where((r) => r.id == recipeId).firstOrNull;
      if (recipe != null) return Right(recipe);
      return Left(ServerFailure());
    } on NetworkException {
      return Left(NetworkFailure());
    } catch (_) {
      return Left(ServerFailure());
    }
  }
}
