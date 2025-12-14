import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failure.dart';
import '../entities/analytics_data.dart';
import '../entities/range.dart';

abstract class AnalyticsRepository {
  Future<Either<Failure, CookingAnalytics>> getCookingAnalytics({
    AnalyticsRange range,
  });
}
