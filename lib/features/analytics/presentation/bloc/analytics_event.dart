part of 'analytics_bloc.dart';

abstract class AnalyticsEvent {}

class LoadAnalytics extends AnalyticsEvent {}

class RefreshAnalytics extends AnalyticsEvent {}

class ChangeRange extends AnalyticsEvent {
  final AnalyticsRange range;

  ChangeRange(this.range);
}
