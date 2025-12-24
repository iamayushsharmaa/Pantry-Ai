import '../../../../../shared/models/recipe/recipe.dart';

abstract class QuickRecipesRepository {
  Future<List<Recipe>> getQuickRecipes({
    required String userId,
    required int maxCookingTime,
  });
}
