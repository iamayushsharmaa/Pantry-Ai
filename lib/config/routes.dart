import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pantry_ai/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pantry_ai/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:pantry_ai/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:pantry_ai/features/dishes/presentation/screens/dishes_detail_screen.dart';
import 'package:pantry_ai/features/dishes/presentation/screens/dishes_list_screen.dart';
import 'package:pantry_ai/features/home/presentation/screens/widget_tree.dart';
import 'package:pantry_ai/splash.dart';

import '../features/auth/domain/repository/auth_repository_impl.dart';
import '../features/auth/presentation/screens/onboarding_screen.dart';
import '../features/home/presentation/screens/home_screen.dart';
import '../features/scan/presentation/screens/scan_screen.dart';

GoRouter createRouter() {
  final initialLocation = '/splash';

  final storage = FlutterSecureStorage();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth firebase_auth = FirebaseAuth.instance;
  final GoogleSignIn google_sign_in = GoogleSignIn();
  final authRepository = AuthRepositoryImpl(
    firestore: firestore,
    firebaseAuth: firebase_auth,
    googleSignIn: google_sign_in,
  );

  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: initialLocation,
    routes: [
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) {
          return BlocProvider(
            create: (context) => AuthBloc(authRepository: authRepository),
            child: Splash(),
          );
        },
      ),
      GoRoute(
        path: '/onboarding',
        name: 'onBoarding',
        builder: (context, state) {
          return BlocProvider(
            create: (context) => AuthBloc(authRepository: authRepository),
            child: OnBoardingScreen(),
          );
        },
      ),

      GoRoute(
        path: '/sign-in',
        name: 'signIn',
        builder: (context, state) {
          return BlocProvider(
            create: (context) => AuthBloc(authRepository: authRepository),
            child: SigninScreen(),
          );
        },
      ),
      GoRoute(
        path: '/sign-up',
        name: 'signUp',
        builder: (context, state) {
          return BlocProvider(
            create: (context) => AuthBloc(authRepository: authRepository),
            child: SignupScreen(),
          );
        },
      ),
      GoRoute(
        path: '/camera',
        name: 'camera',
        builder: (context, state) => ScanScreen(),
      ),
      GoRoute(
        path: '/dishes-detail',
        name: 'dishesDetail',
        builder: (context, state) => DishesDetailScreen(),
      ),
      GoRoute(
        path: '/dishes-list',
        name: 'dishesList',
        builder: (context, state) => DishesListScreen(),
      ),
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
