import '../enities/recipe_entity.dart';
import '../enities/taste_preference_entity.dart';
import '../repository/recipe_repository.dart';

class GenerateRecipesUseCase {
  final RecipeRepository repository;

  GenerateRecipesUseCase(this.repository);

  Future<List<Recipe>> call(
      String imagePath, TastePreferences preferences) {
    return repository.generateRecipes(imagePath, preferences);
  }
}