import '../entities/analytics_data.dart';
import '../entities/range.dart';
import '../repository/analytics_repository.dart';

class GetCookingAnalytics {
  final AnalyticsRepository repository;

  GetCookingAnalytics(this.repository);

  Future<CookingAnalytics> call({
    AnalyticsRange range = AnalyticsRange.all,
  }) async {
    final either = await repository.getCookingAnalytics(range: range);

    return either.fold(
      (_) => CookingAnalytics(
        totalAddedToCooking: 0,
        addedThisWeek: 0,
        topCuisine: '—',
        averageCookingTime: 0,
        favoriteToCookingRatio: 0,
      ),
      (data) => data,
    );
  }
}
