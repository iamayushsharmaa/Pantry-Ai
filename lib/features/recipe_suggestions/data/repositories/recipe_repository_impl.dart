import '../../../../shared/models/recipe/recipe.dart';
import '../../domain/enities/recipe_entity.dart';
import '../../../../shared/models/recipe/taste_preference.dart';
import '../../domain/repository/recipe_repository.dart';
import '../datasource/local/recipe_local_datasource.dart';
import '../datasource/remote/recipe_remote_datasource.dart';
import '../../../../shared/models/recipe/recipe_model.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final RecipeRemoteDataSource remote;
  final RecipeLocalDataSource local;

  RecipeRepositoryImpl({required this.remote, required this.local});

  @override
  Future<List<Recipe>> generateRecipes(
    String imagePath,
    TastePreferences preferences,
    List<RecipeModel>? previouslySuggestedRecipes,
  ) async {
    try {
      final models = await remote.generateRecipes(
        imagePath,
        preferences,
        previouslySuggestedRecipes,
      );

      await local.cacheRecipes(models);

      return models.toList();
    } catch (_) {
      final cache = await local.getCachedRecipes();
      return cache.toList();
    }
  }

  @override
  Future<void> cacheRecipes(List<Recipe> recipes) async {
    try {
      final models = recipes.toList() as List<RecipeModel>;
      await local.cacheRecipes(models);
    } catch (e) {
      print('Error: \$e');
    }
  }

  @override
  Future<List<Recipe>> getCachedRecipes() async {
    final models = await local.getCachedRecipes();
    return models.toList();
  }
}
