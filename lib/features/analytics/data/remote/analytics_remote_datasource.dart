
import '../../../favorites/domain/entities/favorite_recipe_entity.dart';
import '../../../save_recipe/domain/entities/save_recipe_entity.dart';

abstract class AnalyticsLocalDataSource {
  Future<List<SavedRecipe>> getSavedRecipes();
  Future<List<FavoriteRecipe>> getFavoriteRecipes();
}