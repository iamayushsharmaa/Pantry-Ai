import 'package:go_router/go_router.dart';
import 'package:pantry_ai/features/save_recipe/presentation/screens/saved_recipe_screen.dart';

import '../../../core/router/app_route_names.dart';
import '../../../core/router/app_routes.dart';

List<GoRoute> savedRoutes = [
  GoRoute(
    path: AppRoutes.saved,
    name: AppRouteNames.saved,
    builder: (_, __) => SavedRecipesScreen(),
  ),
];
