import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failure.dart';
import '../../../save_recipe/domain/entities/save_recipe_entity.dart';
import '../../domain/entities/analytics_data.dart';
import '../../domain/entities/range.dart';
import '../../domain/repository/analytics_repository.dart';
import '../remote/analytics_remote_datasource.dart';

class AnalyticsRepositoryImpl implements AnalyticsRepository {
  final AnalyticsLocalDataSource localDataSource;

  AnalyticsRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, CookingAnalytics>> getCookingAnalytics({
    AnalyticsRange range = AnalyticsRange.all,
  }) async {
    try {
      final savedRecipesRaw = await localDataSource.getSavedRecipes();
      final favoriteRecipes = await localDataSource.getFavoriteRecipes();

      final savedRecipes = _filterByRange(savedRecipesRaw, range);

      final totalAdded = savedRecipes.length;

      final weekAgo = DateTime.now().subtract(const Duration(days: 7));
      final addedThisWeek = savedRecipes
          .where((e) => e.savedAt.isAfter(weekAgo))
          .length;

      final cuisineCount = <String, int>{};
      for (final s in savedRecipes) {
        cuisineCount[s.recipe.cuisine] =
            (cuisineCount[s.recipe.cuisine] ?? 0) + 1;
      }

      final topCuisine = cuisineCount.isEmpty
          ? '—'
          : cuisineCount.entries
                .reduce((a, b) => a.value > b.value ? a : b)
                .key;

      final avgCookingTime = savedRecipes.isEmpty
          ? 0.0
          : savedRecipes
                    .map((e) => e.recipe.cookingTime)
                    .reduce((a, b) => a + b) /
                savedRecipes.length;

      final favoriteToCookingRatio = favoriteRecipes.isEmpty
          ? 0.0
          : savedRecipes.length / favoriteRecipes.length;

      return Right(
        CookingAnalytics(
          totalAddedToCooking: totalAdded,
          addedThisWeek: addedThisWeek,
          topCuisine: topCuisine,
          averageCookingTime: avgCookingTime,
          favoriteToCookingRatio: favoriteToCookingRatio,
        ),
      );
    } catch (_) {
      return Left(ServerFailure());
    }
  }

  List<SavedRecipe> _filterByRange(
    List<SavedRecipe> recipes,
    AnalyticsRange range,
  ) {
    if (range == AnalyticsRange.all) return recipes;

    final now = DateTime.now();
    final cutoff = range == AnalyticsRange.week
        ? now.subtract(const Duration(days: 7))
        : now.subtract(const Duration(days: 30));

    return recipes.where((r) => r.savedAt.isAfter(cutoff)).toList();
  }
}
