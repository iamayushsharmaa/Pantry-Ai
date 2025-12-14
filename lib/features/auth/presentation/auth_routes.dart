import 'package:go_router/go_router.dart';
import 'package:pantry_ai/features/auth/presentation/screens/onboarding_screen.dart';
import 'package:pantry_ai/features/auth/presentation/screens/sign_up_screen.dart';

import '../../../core/router/app_route_names.dart';
import '../../../core/router/app_routes.dart';
import '../../../splash.dart';
import 'screens/sign_in_screen.dart';

List<GoRoute> authRoutes = [
  GoRoute(
    path: AppRoutes.splash,
    name: AppRouteNames.splash,
    builder: (_, __) => const Splash(),
  ),
  GoRoute(
    path: AppRoutes.onboarding,
    name: AppRouteNames.onboarding,
    builder: (_, __) => OnBoardingScreen(),
  ),
  GoRoute(
    path: AppRoutes.signIn,
    name: AppRouteNames.signIn,
    builder: (_, __) => SigninScreen(),
  ),
  GoRoute(
    path: AppRoutes.signUp,
    name: AppRouteNames.signUp,
    builder: (_, __) => SignupScreen(),
  ),
];
