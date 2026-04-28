import 'package:hive/hive.dart';
import 'package:pantry_ai/features/recipe_suggestions/data/datasource/local/recipe_local_datasource.dart';

import '../../../../../shared/models/recipe/recipe_model.dart';

class RecipeLocalDataSourceImpl implements RecipeLocalDataSource {
  final Box box;

  RecipeLocalDataSourceImpl(this.box);

  static const _cacheKey = 'recipes';
  static const _timestampKey = 'recipes_timestamp';
  static const _cacheDuration = Duration(days: 2);

  @override
  Future<void> cacheRecipes(List<RecipeModel> recipes) async {
    final existing = await getCachedRecipes();
    final existingIds = existing.map((r) => r.id).toSet();

    final merged = [
      ...existing,
      ...recipes.where((r) => !existingIds.contains(r.id)),
    ];

    final jsonList = merged.map((e) => e.toJson()).toList();
    await box.put(_cacheKey, jsonList);
    await box.put(_timestampKey, DateTime.now().millisecondsSinceEpoch);
  }

  @override
  Future<List<RecipeModel>> getCachedRecipes() async {
    final timestamp = box.get(_timestampKey) as int?;
    if (timestamp != null) {
      final savedAt = DateTime.fromMillisecondsSinceEpoch(timestamp);
      final isExpired = DateTime.now().difference(savedAt) > _cacheDuration;
      if (isExpired) {
        await box.delete(_cacheKey);
        await box.delete(_timestampKey);
        return [];
      }
    }

    final raw = box.get(_cacheKey);
    if (raw == null) return [];

    return (raw as List)
        .map((e) => RecipeModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  @override
  Future<void> clearCache() async {
    await box.delete(_cacheKey);
    await box.delete(_timestampKey);
  }
}
