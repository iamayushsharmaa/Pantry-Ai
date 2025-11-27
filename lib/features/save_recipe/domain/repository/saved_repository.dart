import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failure.dart';
import '../../../../shared/models/recipe/recipe.dart';
import '../../../../shared/models/recipe/saved_recipe_model.dart';

abstract class SavedRepository {
  Future<Either<Failure, void>> saveRecipe(Recipe recipe, {String? notes});

  Future<Either<Failure, void>> unsaveRecipe(String recipeId);

  Future<Either<Failure, bool>> isSaved(String recipeId);

  Stream<Either<Failure, List<SavedRecipe>>> getSavedStream();

  Future<Either<Failure, void>> toggleSaved(Recipe recipe, {String? notes});
}
