import '../../../domain/enities/taste_preference_entity.dart';
import '../../../../../shared/models/recipe/recipe_model.dart';

abstract class RecipeRemoteDataSource {
  Future<List<RecipeModel>> generateRecipes(
    String imagePath,
    TastePreferences prefs,
    List<RecipeModel>? previouslySuggestedRecipes,
  );
}
