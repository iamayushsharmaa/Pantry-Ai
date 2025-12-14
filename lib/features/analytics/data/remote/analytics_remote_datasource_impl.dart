import '../../../favorites/domain/entities/favorite_recipe_entity.dart';
import '../../../favorites/domain/repository/favorite_repository.dart';
import '../../../save_recipe/domain/entities/save_recipe_entity.dart';
import '../../../save_recipe/domain/repository/saved_repository.dart';
import 'analytics_remote_datasource.dart';

class AnalyticsLocalDataSourceImpl implements AnalyticsLocalDataSource {
  final SavedRepository savedRepository;
  final FavoriteRepository favoriteRepository;

  AnalyticsLocalDataSourceImpl({
    required this.savedRepository,
    required this.favoriteRepository,
  });

  @override
  Future<List<SavedRecipe>> getSavedRecipes() async {
    final either = await savedRepository.getSavedOnce();
    return either.fold((_) => <SavedRecipe>[], (list) => list);
  }

  @override
  Future<List<FavoriteRecipe>> getFavoriteRecipes() async {
    final either = await favoriteRepository.getFavoritesOnce();
    return either.fold((_) => <FavoriteRecipe>[], (list) => list);
  }
}
