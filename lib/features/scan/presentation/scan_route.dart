import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pantry_ai/features/scan/presentation/screens/scan_screen.dart';

import '../../../core/router/app_route_names.dart';
import '../../../core/router/app_routes.dart';
import 'bloc/scan_bloc.dart';

List<GoRoute> scanRoutes = [
  GoRoute(
    path: AppRoutes.scan,
    name: AppRouteNames.scan,
    builder: (_, __) => BlocProvider(
      create: (_) => ScanBloc()..add(InitializeCamera()),
      child: const ScanScreen(),
    ),
  ),
];
