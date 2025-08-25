import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:pantry_ai/splash.dart';
import 'package:pantry_ai/features/widget_tree.dart';

import '../core/network/dio_client.dart';
import '../features/home_screen.dart';

GoRouter createRouter() {
  final initialLocation = '/home';

  final storage = FlutterSecureStorage();
  final dio = DioClient.create(storage);
  // final authService = AuthService(
  //   dio: dio,
  //   googleSignIn: GoogleSignIn(),
  //   storage: storage,
  // );
  // final authRepository = AuthRepositoryImpl(authService);

  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: initialLocation,
    routes: [
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => Splash(),
      ),

      // GoRoute(
      //   path: '/onboarding',
      //   name: 'onBoarding',
      //   builder: (context, state) =>
      //       BlocProvider(
      //         create: (context) => AuthBloc(authRepository),
      //         child: OnBoardingScreen(),
      //       ),
      // ),
      ShellRoute(
        builder: (context, state, child) => WidgetTree(child: child),
        routes: [
          GoRoute(
            path: '/home',
            name: 'home',
            builder: (context, state) => HomeScreen(),
          ),
          // GoRoute(
          //   path: '/',
          //   name: 'clients',
          //   builder: (context, state) => ClientScreen(),
          // ),
          // GoRoute(
          //   path: '/analytics',
          //   name: 'analytics',
          //   builder: (context, state) => AnalyticsScreen(),
          // ),
        ],
      ),
    ],
    redirect: (context, state) {
      // final authState = context
      //     .read<AuthBloc>()
      //     .state;
      // final currentPath = state.uri.path;
      // final isPublicRoute = [
      //   '/onboarding',
      //   '/signin',
      //   '/signup',
      // ].contains(currentPath);
      //
      // if (authState is Authenticated && isPublicRoute) {
      //   return '/home';
      // }
      // if (authState is Unauthenticated && !isPublicRoute) {
      //   return '/onboarding';
      // }
      return '/home';
    },
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text('Page not found: ${state.uri}'))),
  );
}

// class GoRouterRefresh extends ChangeNotifier {
//   final AuthBloc bloc;
//
//   GoRouterRefresh(this.bloc) {
//     bloc.stream.listen((_) {
//       notifyListeners();
//     });
//   }
// }
