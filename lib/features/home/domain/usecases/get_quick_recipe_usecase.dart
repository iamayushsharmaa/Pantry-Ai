import '../../../../shared/models/recipe/recipe.dart';
import '../repository/quick_repository/quick_recipe_repository.dart';

class GetQuickRecipesUseCase {
  final QuickRecipesRepository repository;

  GetQuickRecipesUseCase(this.repository);

  Future<List<Recipe>> call(String userId) {
    return repository.getQuickRecipes(userId: userId, maxCookingTime: 30);
  }
}
