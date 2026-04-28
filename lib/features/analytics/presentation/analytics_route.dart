import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pantry_ai/features/analytics/presentation/screens/analytics_screen.dart';

import '../../../core/di/injections.dart';
import '../../../core/router/app_route_names.dart';
import '../../../core/router/app_routes.dart';
import 'bloc/analytics_bloc.dart';

List<GoRoute> analyticsRoute = [
  GoRoute(
    path: AppRoutes.analytics,
    name: AppRouteNames.analytics,
    builder: (_, __) => BlocProvider(
      create: (_) => sl<AnalyticsBloc>()..add(LoadAnalytics()),
      child: const AnalyticsScreen(),
    ),
  ),
];
