import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failure.dart';
import '../../../../shared/models/recipe/recipe.dart';
import '../repository/recipe_detail_repository.dart';

class GetRecipeById {
  final RecipeDetailRepository repository;

  GetRecipeById(this.repository);

  @override
  Future<Either<Failure, Recipe>> call(String recipeId) async {
    return await repository.getRecipeById(recipeId);
  }
}
