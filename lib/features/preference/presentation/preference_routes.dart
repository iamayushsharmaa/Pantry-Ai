import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pantry_ai/features/preference/presentation/screens/taste_preference_screen.dart';

import '../../../core/router/app_route_names.dart';
import '../../../core/router/app_routes.dart';
import 'bloc/taste_preference_bloc.dart';

List<GoRoute> tasteRoutes = [
  GoRoute(
    path: AppRoutes.tastePreference,
    name: AppRouteNames.tastePreference,
    builder: (_, state) {
      final imagePath = state.extra! as String;
      return BlocProvider(
        create: (_) => TastePreferenceBloc(),
        child: TastePreferenceScreen(imagePath: imagePath),
      );
    },
  ),
];
