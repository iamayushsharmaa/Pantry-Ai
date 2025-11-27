import '../../../../shared/models/recipe/recipe.dart';
import '../repository/recipe_repository.dart';

class CacheRecipesUseCase {
  final RecipeRepository repository;

  CacheRecipesUseCase(this.repository);

  Future<void> call(List<Recipe> recipes) {
    return repository.cacheRecipes(recipes);
  }
}
