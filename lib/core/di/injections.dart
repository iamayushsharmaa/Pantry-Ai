import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pantry_ai/core/app_settings/app_settings_bloc.dart';
import 'package:pantry_ai/features/analytics/data/remote/analytics_remote_datasource.dart';
import 'package:pantry_ai/features/analytics/domain/repository/analytics_repository.dart';
import 'package:pantry_ai/features/analytics/domain/usecases/get_cooking_analytics.dart';
import 'package:pantry_ai/features/auth/data/remote/auth_local_data_source_impl.dart';
import 'package:pantry_ai/features/auth/data/remote/auth_remote_datasource.dart';
import 'package:pantry_ai/features/auth/data/remote/auth_remote_datasource_impl.dart';
import 'package:pantry_ai/features/auth/data/remote/profile_remote_datasource.dart';
import 'package:pantry_ai/features/auth/data/remote/profile_remote_datasource_impl.dart';
import 'package:pantry_ai/features/auth/domain/usecases/update_profile_photo_usecase.dart';
import 'package:pantry_ai/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pantry_ai/features/home/presentation/bloc/recent_bloc/home_bloc.dart';
import 'package:pantry_ai/features/preference/presentation/bloc/taste_preference_bloc.dart';
import 'package:pantry_ai/features/recipe_detail/data/remote/recipe_detail_datasource.dart';
import 'package:pantry_ai/features/recipe_detail/data/remote/recipe_detail_datasource_impl.dart';
import 'package:pantry_ai/features/recipe_detail/domain/repository/recipe_detail_repository.dart';
import 'package:pantry_ai/features/recipe_detail/presentation/bloc/recipe_detail_bloc.dart';
import 'package:pantry_ai/features/scan/presentation/bloc/scan_bloc.dart';
import 'package:pantry_ai/features/settings/presentation/bloc/settings_bloc.dart';

import '../../features/analytics/data/remote/analytics_remote_datasource_impl.dart';
import '../../features/analytics/data/repository/analytics_repository_impl.dart';
import '../../features/analytics/presentation/bloc/analytics_bloc.dart';
import '../../features/auth/data/remote/auth_local_data_source.dart';
import '../../features/auth/data/repository/auth_repository_impl.dart';
import '../../features/auth/domain/repository/auth_repository.dart';
import '../../features/auth/domain/usecases/check_auth_status_usecase.dart';
import '../../features/auth/domain/usecases/delete_account_usecase.dart';
import '../../features/auth/domain/usecases/register_usecase.dart';
import '../../features/auth/domain/usecases/sign_in_google_usecase.dart';
import '../../features/auth/domain/usecases/sign_in_usecase.dart';
import '../../features/auth/domain/usecases/sign_out_usecase.dart';
import '../../features/auth/domain/usecases/update_email_usecase.dart';
import '../../features/auth/domain/usecases/update_name_usecase.dart';
import '../../features/home/domain/usecases/get_recent_recipe_usecase.dart';
import '../../features/recipe_detail/data/repository/recipe_detail_repository_impl.dart';
import '../../features/recipe_detail/domain/usecases/get_recipe_by_id.dart';
import '../../features/recipe_suggestions/data/datasource/local/recipe_local_datasource.dart';
import '../../features/recipe_suggestions/data/datasource/local/recipe_local_datasource_impl.dart';
import '../../features/recipe_suggestions/data/datasource/remote/recipe_remote_datasource.dart';
import '../../features/recipe_suggestions/data/datasource/remote/recipe_remote_datasource_impl.dart';
import '../../features/recipe_suggestions/data/repositories/recipe_repository_impl.dart';
import '../../features/recipe_suggestions/domain/repository/recipe_repository.dart';
import '../../features/recipe_suggestions/domain/usecases/cache_reccipe_usecase.dart';
import '../../features/recipe_suggestions/domain/usecases/generate_recipe_usecase.dart';
import '../../features/recipe_suggestions/domain/usecases/get_cached_recipes_usecase.dart';
import '../../features/saved/data/datasource/favorite_data_source.dart';
import '../../features/saved/data/datasource/favorite_data_source_impl.dart';
import '../../features/saved/data/datasource/saved_datasource.dart';
import '../../features/saved/data/datasource/saved_datasource_impl.dart';
import '../../features/saved/data/repository/favorite_repository_impl.dart';
import '../../features/saved/data/repository/saved_repository_impl.dart';
import '../../features/saved/domain/repository/favorite_repository.dart';
import '../../features/saved/domain/repository/saved_repository.dart';
import '../../features/saved/domain/usecases/get_favorite_stream.dart';
import '../../features/saved/domain/usecases/get_saved_stream.dart';
import '../../features/saved/domain/usecases/toggle_favorite.dart';
import '../../features/saved/domain/usecases/toogle_saved.dart';
import '../../features/saved/presentation/bloc/favourite_bloc/favorites_bloc.dart';
import '../../features/saved/presentation/bloc/saved_bloc/saved_bloc.dart';
import '../network/network_info.dart';
import '../services/image_picker_services.dart';
import '../utils/firebase_auth_service.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  await _initHiveBoxes();
  _initFirebase();
  _initExternalServices();
  _initPreferenceFeature();
  _initAuthFeature();
  _initHomeFeature();
  _initScanFeature();
  _initRecipeFeature();
  _initFavoriteFeature();
  _initSavedFeature();
  _initSettingsFeature();
  _initAnalyticsFeature();
}

void _initFirebase() {
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  sl.registerLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance);

  sl.registerLazySingleton<fb.FirebaseAuth>(() => fb.FirebaseAuth.instance);

  sl.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn());
}

void _initExternalServices() {
  sl.registerLazySingleton<Dio>(() {
    final dio = Dio();
    dio.options.connectTimeout = const Duration(seconds: 10);
    return dio;
  });

  sl.registerLazySingleton<AuthService>(
    () => FirebaseAuthService(firebaseAuth: fb.FirebaseAuth.instance),
  );

  sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<ImagePickerService>(() => ImagePickerServiceImpl());
}

Future<void> _initHiveBoxes() async {
  final recipesBox = await Hive.openBox('recipesBox');

  sl.registerSingleton<Box>(recipesBox);
}

Future<void> _initRecipeFeature() async {
  sl.registerLazySingleton<RecipeRemoteDataSource>(
    () => RecipeRemoteDataSourceImpl(sl<Dio>()),
  );

  sl.registerLazySingleton<RecipeLocalDataSource>(
    () => RecipeLocalDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<RecipeRepository>(
    () => RecipeRepositoryImpl(remote: sl(), local: sl()),
  );

  sl.registerLazySingleton<RecipeDetailRemoteDataSource>(
    () => RecipeDetailRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<RecipeDetailRepository>(
    () => RecipeDetailRepositoryImpl(sl()),
  );

  sl.registerLazySingleton(() => GetRecipeById(sl()));

  sl.registerLazySingleton(() => GenerateRecipesUseCase(sl()));
  sl.registerLazySingleton(() => GetCachedRecipesUseCase(sl()));
  sl.registerLazySingleton(() => CacheRecipesUseCase(sl()));
  sl.registerFactory<RecipeDetailBloc>(
    () => RecipeDetailBloc(getRecipeById: sl()),
  );
}

Future<void> _initHomeFeature() async {
  sl.registerLazySingleton(() => GetRecentRecipesUseCase(sl()));

  sl.registerFactory<HomeBloc>(() => HomeBloc(getRecentRecipes: sl()));
}

Future<void> _initScanFeature() async {
  sl.registerFactory<ScanBloc>(() => ScanBloc());
}

Future<void> _initPreferenceFeature() async {
  sl.registerFactory<TastePreferenceBloc>(() => TastePreferenceBloc());
}

Future<void> _initAuthFeature() async {
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      firebaseAuth: sl(),
      firestore: sl(),
      googleSignIn: sl(),
    ),
  );

  sl.registerLazySingleton<ProfileImageRemoteDataSource>(
    () => ProfileImageRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(networkInfo: sl(), remoteDataSource: sl()),
  );

  sl.registerLazySingleton(() => CheckAuthStatusUseCase(sl()));
  sl.registerLazySingleton(() => ContinueWithGoogleUseCase(sl()));
  sl.registerLazySingleton(() => SignInUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => SignOutUseCase(sl()));
  sl.registerLazySingleton(() => DeleteAccountUseCase(sl()));

  sl.registerFactory<AuthBloc>(
    () => AuthBloc(
      checkAuthStatus: sl(),
      continueWithGoogle: sl(),
      signIn: sl(),
      register: sl(),
      signOut: sl(),
      deleteAccount: sl(),
    ),
  );
}

Future<void> _initAnalyticsFeature() async {
  sl.registerLazySingleton<AnalyticsLocalDataSource>(
    () => AnalyticsLocalDataSourceImpl(
      savedRepository: sl(),
      favoriteRepository: sl(),
    ),
  );

  sl.registerLazySingleton<AnalyticsRepository>(
    () => AnalyticsRepositoryImpl(sl()),
  );

  sl.registerLazySingleton(() => GetCookingAnalytics(sl()));

  sl.registerFactory<AnalyticsBloc>(() => AnalyticsBloc(getAnalytics: sl()));
}

Future<void> _initFavoriteFeature() async {
  sl.registerLazySingleton<FavoriteRemoteDataSource>(
    () => FavoriteRemoteDataSourceImpl(firestore: sl(), auth: sl()),
  );

  sl.registerLazySingleton<FavoriteRepository>(
    () => FavoriteRepositoryImpl(auth: sl(), remote: sl()),
  );

  sl.registerLazySingleton(() => ToggleFavorite(sl()));
  sl.registerLazySingleton(() => GetFavoritesStream(sl()));

  sl.registerFactory<FavoritesBloc>(
    () => FavoritesBloc(toggleFavorite: sl(), getFavoritesStream: sl()),
  );
}

Future<void> _initSavedFeature() async {
  sl.registerLazySingleton<SavedRemoteDataSource>(
    () => SavedRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<SavedRepository>(
    () => SavedRepositoryImpl(remote: sl(), auth: sl()),
  );

  sl.registerLazySingleton(() => ToggleSaved(sl()));
  sl.registerLazySingleton(() => GetSavedStream(sl()));

  sl.registerFactory<SavedBloc>(
    () => SavedBloc(toggleSaved: sl(), getSavedStream: sl()),
  );
}

Future<void> _initSettingsFeature() async {
  sl.registerLazySingleton(() => UpdateNameUseCase(sl()));
  sl.registerLazySingleton(() => UpdateEmailUseCase(sl()));

  sl.registerLazySingleton(
    () => UpdateProfilePhotoUseCase(
      authRepository: sl(),
      imageRemoteDataSource: sl(),
    ),
  );

  sl.registerFactory<AppSettingsBloc>(() => AppSettingsBloc());

  sl.registerFactory<SettingsBloc>(
    () => SettingsBloc(
      checkAuthStatusUseCase: sl(),
      updateEmailUseCase: sl(),
      updateNameUseCase: sl(),
      updateProfilePhotoUseCase: sl(),
      signOutUseCase: sl(),
      deleteAccountUseCase: sl(),
    ),
  );
}
