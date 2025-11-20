import 'package:pantry_ai/features/recipe_suggestions/domain/enities/recipe_entity.dart';

import 'package:pantry_ai/features/recipe_suggestions/domain/enities/taste_preference_entity.dart';

import '../../domain/repository/recipe_repository.dart';

class RecipeRepositoryImpl implements RecipeRepository{
  @override
  Future<void> cacheRecipes(List<Recipe> recipes) {
    // TODO: implement cacheRecipes
    throw UnimplementedError();
  }

  @override
  Future<List<Recipe>> generateRecipes(String imagePath, TastePreferences preferences) {
    // TODO: implement generateRecipes
    throw UnimplementedError();
  }


  @override
  Future<List<Recipe>> getCachedRecipes() {
    // TODO: implement getCachedRecipes
    throw UnimplementedError();
  }

}