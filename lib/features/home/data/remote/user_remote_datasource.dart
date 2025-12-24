import 'package:pantry_ai/shared/models/recipe/recipe_model.dart';

abstract class UserRecipesRemoteDataSource {
  Future<List<RecipeModel>> getQuickRecipes({
    required String userId,
    required int maxCookingTime,
  });
}
