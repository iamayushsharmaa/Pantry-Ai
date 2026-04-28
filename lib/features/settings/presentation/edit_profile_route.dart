import 'package:go_router/go_router.dart';
import 'package:pantry_ai/features/settings/presentation/screens/edit_profile_screen.dart';

import '../../../core/di/injections.dart';
import '../../../core/router/app_route_names.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/services/image_picker_services.dart';

List<GoRoute> editProfileRoutes = [
  GoRoute(
    path: AppRoutes.editProfile,
    name: AppRouteNames.editProfile,
    builder: (_, __) =>
        EditProfileScreen(imagePickerService: sl<ImagePickerService>()),
  ),
];
