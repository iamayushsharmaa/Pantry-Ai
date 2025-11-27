import '../../../../shared/models/recipe/recipe.dart';
import '../repository/recipe_repository.dart';

class GetCachedRecipesUseCase {
  final RecipeRepository repository;

  GetCachedRecipesUseCase(this.repository);

  Future<List<Recipe>> call() {
    return repository.getCachedRecipes();
  }
}
