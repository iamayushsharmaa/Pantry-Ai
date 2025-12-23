import '../../../../shared/models/mappers/recipe_mapper.dart';
import '../../../../shared/models/recipe/recipe.dart';
import '../../../../shared/models/recipe/recipe_model.dart';
import '../../../../shared/models/recipe/taste_preference.dart';
import '../../domain/repository/recipe_repository.dart';
import '../datasource/local/recipe_local_datasource.dart';
import '../datasource/remote/recipe_remote_datasource.dart';

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

      return models;
    } catch (_) {
      final cachedModels = await local.getCachedRecipes();
      return cachedModels;
    }
  }

  @override
  Future<void> cacheRecipes(List<Recipe> recipes) async {
    final models = recipes.map(RecipeMapper.toModel).toList();
    await local.cacheRecipes(models);
  }

  @override
  Future<List<Recipe>> getCachedRecipes() async {
    final models = await local.getCachedRecipes();
    return models;
  }
}
