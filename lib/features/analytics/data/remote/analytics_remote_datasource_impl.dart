import '../../../../shared/models/saved_recipe/save_recipe.dart';
import '../../../saved/domain/entities/favorite_recipe_entity.dart';
import '../../../saved/domain/repository/favorite_repository.dart';
import '../../../saved/domain/repository/saved_repository.dart';
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
