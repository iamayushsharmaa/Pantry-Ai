import 'package:hive/hive.dart';
import 'package:pantry_ai/features/recipe_suggestions/data/datasource/local/recipe_local_datasource.dart';

import '../../../../../shared/models/recipe/recipe_model.dart';

class RecipeLocalDataSourceImpl implements RecipeLocalDataSource {
  final Box box;

  RecipeLocalDataSourceImpl(this.box);

  static const _cacheKey = 'recipes';

  @override
  Future<void> cacheRecipes(List<RecipeModel> recipes) async {
    final jsonList = recipes.map((e) => e.toJson()).toList();
    await box.put(_cacheKey, jsonList);
  }

  @override
  Future<List<RecipeModel>> getCachedRecipes() async {
    final raw = box.get(_cacheKey);
    if (raw == null) return [];

    return (raw as List)
        .map((e) => RecipeModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }
}
