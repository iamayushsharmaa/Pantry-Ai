import '../../../../../shared/models/recipe/taste_preference.dart';
import '../../../../../shared/models/recipe/recipe_model.dart';

abstract class RecipeRemoteDataSource {
  Future<List<RecipeModel>> generateRecipes(
    String imagePath,
    TastePreferences prefs,
    List<RecipeModel>? previouslySuggestedRecipes,
  );
}
