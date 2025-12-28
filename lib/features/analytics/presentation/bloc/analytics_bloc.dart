import 'package:bloc/bloc.dart';

import '../../domain/entities/analytics_data.dart';
import '../../domain/entities/range.dart';
import '../../domain/usecases/get_cooking_analytics.dart';

part 'analytics_event.dart';
part 'analytics_state.dart';

class AnalyticsBloc extends Bloc<AnalyticsEvent, AnalyticsState> {
  final GetCookingAnalytics getAnalytics;

  AnalyticsBloc({required this.getAnalytics}) : super(AnalyticsLoading()) {
    on<LoadAnalytics>(_load);
    on<RefreshAnalytics>(_refresh);
    on<ChangeRange>(_changeRange);
  }

  AnalyticsRange _currentRange = AnalyticsRange.all;

  Future<void> _load(LoadAnalytics event, Emitter<AnalyticsState> emit) async {
    emit(AnalyticsLoading());

    final analytics = await getAnalytics(range: _currentRange);

    emit(AnalyticsLoaded(analytics: analytics, range: _currentRange));
  }

  Future<void> _refresh(
    RefreshAnalytics event,
    Emitter<AnalyticsState> emit,
  ) async {
    final analytics = await getAnalytics(range: _currentRange);

    emit(AnalyticsLoaded(analytics: analytics, range: _currentRange));
  }

  Future<void> _changeRange(
    ChangeRange event,
    Emitter<AnalyticsState> emit,
  ) async {
    _currentRange = event.range;

    final analytics = await getAnalytics(range: _currentRange);

    emit(AnalyticsLoaded(analytics: analytics, range: _currentRange));
  }
}
