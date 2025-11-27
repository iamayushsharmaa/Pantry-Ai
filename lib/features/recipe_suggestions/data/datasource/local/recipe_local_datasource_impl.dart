import 'package:hive/hive.dart';
import 'package:pantry_ai/features/recipe_suggestions/data/datasource/local/recipe_local_datasource.dart';

import '../../../../../shared/models/recipe/recipe_model.dart';

class RecipeLocalDataSourceImpl implements RecipeLocalDataSource {
  final Box box;

  RecipeLocalDataSourceImpl(this.box);

  @override
  Future<void> cacheRecipes(List<RecipeModel> recipes) async {
    await box.put("recipes", recipes.toList());
  }

  @override
  Future<List<RecipeModel>> getCachedRecipes() async {
    final raw = box.get("recipes");
    if (raw == null) return [];

    return (raw as List).map((e) => RecipeModel.fromJson(e)).toList();
  }
}
