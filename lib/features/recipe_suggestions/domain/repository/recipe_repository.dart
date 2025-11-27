import '../../../../shared/models/recipe/recipe_model.dart';
import '../enities/recipe_entity.dart';
import '../enities/taste_preference_entity.dart';

abstract interface class RecipeRepository {
  Future<List<Recipe>> generateRecipes(
    String imagePath,
    TastePreferences preferences,
    List<RecipeModel>? previouslySuggestedRecipes,
  );

  Future<void> cacheRecipes(List<Recipe> recipes);

  Future<List<Recipe>> getCachedRecipes();
}
