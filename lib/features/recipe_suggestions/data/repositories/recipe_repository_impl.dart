import 'package:pantry_ai/features/recipe_suggestions/domain/enities/recipe_entity.dart';
import 'package:pantry_ai/features/recipe_suggestions/domain/enities/taste_preference_entity.dart';

import '../../domain/repository/recipe_repository.dart';
import '../datasource/local/recipe_local_datasource.dart';
import '../datasource/remote/recipe_remote_datasource.dart';
import '../models/recipe_model.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final RecipeRemoteDataSource remote;
  final RecipeLocalDataSource local;

  RecipeRepositoryImpl({required this.remote, required this.local});

  @override
  Future<List<Recipe>> generateRecipes(
    String imagePath,
    TastePreferences preferences,
  ) async {
    try {
      final models = await remote.generateRecipes(imagePath, preferences);

      await local.cacheRecipes(models);

      return models.map((m) => m.toEntity()).toList();
    } catch (_) {
      final cache = await local.getCachedRecipes();

      return cache.map((m) => m.toEntity()).toList();
    }
  }

  @override
  Future<void> cacheRecipes(List<Recipe> recipes) async {
    try {
      final models = recipes.map((e) => RecipeModel.fromEntity(e)).toList();
      await local.cacheRecipes(models);
    } catch (e) {
      print('Error: \$e');
    }
  }

  @override
  Future<List<Recipe>> getCachedRecipes() async {
    final models = await local.getCachedRecipes();
    return models.map((e) => e.toEntity()).toList();
  }
}
