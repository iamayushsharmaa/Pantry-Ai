import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pantry_ai/features/auth/data/remote/auth_local_data_source_impl.dart';
import 'package:pantry_ai/features/auth/data/remote/auth_remote_datasource.dart';
import 'package:pantry_ai/features/auth/data/remote/auth_remote_datasource_impl.dart';
import 'package:pantry_ai/features/favorites/data/repository/favorite_repository_impl.dart';
import 'package:pantry_ai/features/favorites/domain/usecases/toggle_favorite.dart';
import 'package:pantry_ai/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:pantry_ai/features/preference/presentation/bloc/taste_preference_bloc.dart';
import 'package:pantry_ai/features/recipe_detail/domain/repository/recipe_detail_repository.dart';
import 'package:pantry_ai/features/save_recipe/data/datasource/saved_datasource.dart';
import 'package:pantry_ai/features/save_recipe/data/datasource/saved_datasource_impl.dart';
import 'package:pantry_ai/features/save_recipe/domain/repository/saved_repository.dart';
import 'package:pantry_ai/features/save_recipe/presentation/bloc/saved_bloc.dart';
import 'package:pantry_ai/features/scan/presentation/bloc/scan_bloc.dart';
import 'package:pantry_ai/features/settings/presentation/bloc/settings_bloc.dart';

import '../../features/auth/data/remote/auth_local_data_source.dart';
import '../../features/auth/data/repository/auth_repository_impl.dart';
import '../../features/auth/domain/repository/auth_repository.dart';
import '../../features/auth/domain/usecases/check_auth_status_usecase.dart';
import '../../features/auth/domain/usecases/delete_account_usecase.dart';
import '../../features/auth/domain/usecases/register_usecase.dart';
import '../../features/auth/domain/usecases/sign_in_google_usecase.dart';
import '../../features/auth/domain/usecases/sign_in_usecase.dart';
import '../../features/auth/domain/usecases/sign_out_usecase.dart';
import '../../features/favorites/data/remote/favorite_data_source.dart';
import '../../features/favorites/data/remote/favorite_data_source_impl.dart';
import '../../features/favorites/domain/repository/favorite_repository.dart';
import '../../features/favorites/domain/usecases/get_favorite_stream.dart';
import '../../features/recipe_detail/data/repository/recipe_detail_repository_impl.dart';
import '../../features/recipe_suggestions/data/datasource/local/recipe_local_datasource.dart';
import '../../features/recipe_suggestions/data/datasource/local/recipe_local_datasource_impl.dart';
import '../../features/recipe_suggestions/data/datasource/remote/recipe_remote_datasource.dart';
import '../../features/recipe_suggestions/data/datasource/remote/recipe_remote_datasource_impl.dart';
import '../../features/recipe_suggestions/data/repositories/recipe_repository_impl.dart';
import '../../features/recipe_suggestions/domain/repository/recipe_repository.dart';
import '../../features/recipe_suggestions/domain/usecases/cache_reccipe_usecase.dart';
import '../../features/recipe_suggestions/domain/usecases/generate_recipe_usecase.dart';
import '../../features/recipe_suggestions/domain/usecases/get_cached_recipes_usecase.dart';
import '../../features/save_recipe/data/repository/saved_repository_impl.dart';
import '../../features/save_recipe/domain/usecases/get_saved_stream.dart';
import '../../features/save_recipe/domain/usecases/toogle_saved.dart';
import '../network/network_info.dart';
import '../utils/firebase_auth_service.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  await _initHiveBoxes();
  _initFirebase();
  _initExternalServices();
  _initPreferenceFeature();
  _initAuthFeature();
  _initRecipeFeature();
  _initFavoriteFeature();
  _initSavedFeature();
  _initScanFeature();
  _initSettingsFeature();
}

void _initFirebase() {
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

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
}

Future<void> _initHiveBoxes() async {
  await Hive.initFlutter();
  final recipeBox = await Hive.openBox('recipesBox');
  sl.registerLazySingleton<Box>(() => recipeBox);
}

Future<void> _initRecipeFeature() async {
  sl.registerLazySingleton<RecipeRemoteDataSource>(
    () => RecipeRemoteDataSourceImpl(sl<Dio>()),
  );

  sl.registerLazySingleton<RecipeLocalDataSource>(
    () => RecipeLocalDataSourceImpl(sl<Box>()),
  );
  sl.registerLazySingleton<RecipeRepository>(
    () => RecipeRepositoryImpl(remote: sl(), local: sl()),
  );

  sl.registerLazySingleton<RecipeDetailRepository>(
    () => RecipeDetailRepositoryImpl(sl()),
  );

  sl.registerLazySingleton(() => GenerateRecipesUseCase(sl()));
  sl.registerLazySingleton(() => GetCachedRecipesUseCase(sl()));
  sl.registerLazySingleton(() => CacheRecipesUseCase(sl()));
}

Future<void> _initScanFeature() async {
  sl.registerLazySingleton<ScanBloc>(() => ScanBloc());
}

Future<void> _initPreferenceFeature() async {
  sl.registerLazySingleton<TastePreferenceBloc>(() => TastePreferenceBloc());
}

Future<void> _initAuthFeature() async {
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      firebaseAuth: sl(),
      firestore: sl(),
      googleSignIn: sl(),
    ),
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
}

Future<void> _initFavoriteFeature() async {
  sl.registerLazySingleton<FavoriteRemoteDataSource>(
    () => FavoriteRemoteDataSourceImpl(firestore: sl(), auth: sl()),
  );

  sl.registerLazySingleton<FavoriteRepository>(
    () => FavoriteRepositoryImpl(sl()),
  );

  sl.registerLazySingleton(() => ToggleFavorite(sl()));
  sl.registerLazySingleton(() => GetFavoritesStream(sl()));

  sl.registerFactory(
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

  sl.registerFactory(() => SavedBloc(toggleSaved: sl(), getSavedStream: sl()));
}

Future<void> _initSettingsFeature() async {
  sl.registerLazySingleton<SettingsBloc>(() => SettingsBloc());
}
