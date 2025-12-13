import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failure.dart';
import '../../../../shared/models/recipe/recipe.dart';
import '../entities/save_recipe_entity.dart';

abstract class SavedRepository {
  Future<Either<Failure, void>> saveRecipe(Recipe recipe, {String? notes});

  Future<Either<Failure, void>> unsaveRecipe(String recipeId);

  Future<Either<Failure, bool>> isSaved(String recipeId);

  Stream<Either<Failure, List<SavedRecipe>>> getSavedStream();

  Future<Either<Failure, void>> toggleSaved(Recipe recipe, {String? notes});
}
