
import '../../../saved/domain/entities/favorite_recipe_entity.dart';
import '../../../../shared/models/saved_recipe/save_recipe.dart';

abstract class AnalyticsLocalDataSource {
  Future<List<SavedRecipe>> getSavedRecipes();
  Future<List<FavoriteRecipe>> getFavoriteRecipes();
}