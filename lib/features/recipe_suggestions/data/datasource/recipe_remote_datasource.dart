import '../../domain/enities/taste_preference_entity.dart';
import '../models/recipe_model.dart';

abstract class RecipeRemoteDataSource {
  Future<List<RecipeModel>> generateRecipes(
    String imagePath,
    TastePreferences prefs,
  );
}

class RecipeRemoteDataSourceImpl implements RecipeRemoteDataSource {
  @override
  Future<List<RecipeModel>> generateRecipes(
    String imagePath,
    TastePreferences prefs,
  ) {
    // TODO: implement generateRecipes
    throw UnimplementedError();
  }
}
