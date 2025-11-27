import '../../../../shared/models/recipe/recipe.dart';
import '../../../../shared/models/recipe/recipe_model.dart';
import '../../../../shared/models/recipe/taste_preference.dart';
import '../repository/recipe_repository.dart';

class GenerateRecipesUseCase {
  final RecipeRepository repository;

  GenerateRecipesUseCase(this.repository);

  Future<List<Recipe>> call(
    String imagePath,
    TastePreferences preferences,
    List<RecipeModel>? previouslySuggestedRecipes,
  ) {
    return repository.generateRecipes(
      imagePath,
      preferences,
      previouslySuggestedRecipes,
    );
  }
}
