import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failure.dart';
import '../../../../shared/models/recipe/recipe.dart';
import '../../domain/repository/recipe_detail_repository.dart';
import '../remote/recipe_detail_datasource.dart';

class RecipeDetailRepositoryImpl implements RecipeDetailRepository {
  final RecipeDetailRemoteDataSource remote;

  RecipeDetailRepositoryImpl(this.remote);

  @override
  Future<Either<Failure, Recipe>> getRecipeById(String recipeId) async {
    try {
      final model = await remote.getRecipeById(recipeId);
      return Right(model);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
