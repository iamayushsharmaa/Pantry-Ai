import '../../../../shared/models/recipe/recipe.dart';
import '../../../recipe_suggestions/domain/repository/recipe_repository.dart';

class GetRecentRecipesUseCase {
  final RecipeRepository repository;

  GetRecentRecipesUseCase(this.repository);

  Future<List<Recipe>> call() {
    return repository.getCachedRecipes();
  }
}
