import '../model/saved_recipe_model.dart';

abstract class SavedRemoteDataSource {
  Future<void> saveRecipe({
    required String uid,
    required SavedRecipeModel recipe,
  });

  Future<void> unsaveRecipe({required String uid, required String recipeId});

  Future<bool> isSaved({required String uid, required String recipeId});

  Stream<List<SavedRecipeModel>> getSavedStream(String uid);
}
