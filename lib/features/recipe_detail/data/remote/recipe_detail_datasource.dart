import '../../../../shared/models/recipe/recipe_model.dart';

abstract class RecipeDetailRemoteDataSource {
  Future<RecipeModel> getRecipeById(String recipeId);
}