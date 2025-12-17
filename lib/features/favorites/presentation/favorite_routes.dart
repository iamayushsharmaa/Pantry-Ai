import 'package:go_router/go_router.dart';
import 'package:pantry_ai/features/favorites/presentation/screens/favorite_screen.dart';

import '../../../core/router/app_route_names.dart';
import '../../../core/router/app_routes.dart';

List<GoRoute> favoriteRoutes = [
  GoRoute(
    path: AppRoutes.favorites,
    name: AppRouteNames.favorites,
    builder: (_, __) => FavoritesScreen(),
  ),
];
