part of 'analytics_bloc.dart';

abstract class AnalyticsState {}

class AnalyticsLoading extends AnalyticsState {}

class AnalyticsLoaded extends AnalyticsState {
  final CookingAnalytics analytics;
  final AnalyticsRange range;

  AnalyticsLoaded({required this.analytics, required this.range});
}
