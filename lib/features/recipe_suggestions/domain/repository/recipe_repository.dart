import '../../../../shared/models/recipe/recipe.dart';
import '../../../../shared/models/recipe/taste_preference.dart';

abstract interface class RecipeRepository {
  Future<List<Recipe>> generateRecipes(
    String imagePath,
    TastePreferences preferences,
    List<Recipe>? previouslySuggestedRecipes,
  );

  Future<void> cacheRecipes(List<Recipe> recipes);

  Future<List<Recipe>> getCachedRecipes();
}
