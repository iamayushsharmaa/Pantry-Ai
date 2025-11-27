import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failure.dart';
import '../../../../shared/models/recipe/recipe.dart';

abstract class RecipeDetailRepository {
  Future<Either<Failure, Recipe>> getRecipeById(String recipeId);
}
