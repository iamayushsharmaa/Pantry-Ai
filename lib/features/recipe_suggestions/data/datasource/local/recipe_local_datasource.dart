import '../../../../../shared/models/recipe/recipe_model.dart';

abstract class RecipeLocalDataSource {
  Future<void> cacheRecipes(List<RecipeModel> recipes);
  Future<List<RecipeModel>> getCachedRecipes();
}
