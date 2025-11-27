import '../../../../shared/models/recipe/recipe_model.dart';
import '../../../../shared/models/recipe/saved_recipe_model.dart';

abstract class SavedRemoteDataSource {
  Future<void> saveRecipe(RecipeModel recipe, {String? notes});

  Future<void> unsaveRecipe(String recipeId);

  Future<bool> isSaved(String recipeId);

  Stream<List<SavedRecipe>> getSavedStream();
}
