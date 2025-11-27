import '../../../../shared/models/recipe/recipe.dart';
import '../../../../shared/models/recipe/recipe_model.dart';
import '../../../../shared/models/recipe/taste_preference.dart';

abstract interface class RecipeRepository {
  Future<List<Recipe>> generateRecipes(
    String imagePath,
    TastePreferences preferences,
    List<RecipeModel>? previouslySuggestedRecipes,
  );

  Future<void> cacheRecipes(List<Recipe> recipes);

  Future<List<Recipe>> getCachedRecipes();
}
