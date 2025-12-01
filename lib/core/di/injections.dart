import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pantry_ai/features/auth/data/remote/auth_remote_datasource.dart';
import 'package:pantry_ai/features/auth/data/remote/auth_remote_datasource_impl.dart';

import '../../features/auth/data/repository/auth_repository_impl.dart';
import '../../features/auth/domain/repository/auth_repository.dart';
import '../../features/auth/domain/usecases/check_auth_status_usecase.dart';
import '../../features/auth/domain/usecases/delete_account_usecase.dart';
import '../../features/auth/domain/usecases/register_usecase.dart';
import '../../features/auth/domain/usecases/sign_in_google_usecase.dart';
import '../../features/auth/domain/usecases/sign_in_usecase.dart';
import '../../features/auth/domain/usecases/sign_out_usecase.dart';
import '../../features/cooking_session/data/datasource/cooking_session_datasource_impl.dart';
import '../../features/cooking_session/data/datasource/cooking_session_datasources.dart';
import '../../features/cooking_session/data/repository/cooking_session_repository_impl.dart';
import '../../features/cooking_session/domain/repository/cooking_repository.dart';
import '../../features/cooking_session/domain/usecases/complete_cooking.dart';
import '../../features/cooking_session/domain/usecases/get_active_session.dart';
import '../../features/cooking_session/domain/usecases/start_cooking.dart';
import '../../features/cooking_session/domain/usecases/toogle_ingredient.dart';
import '../../features/cooking_session/domain/usecases/update_cooking_step.dart';
import '../../features/cooking_session/presentation/bloc/cooking_session_bloc.dart';
import '../../features/recipe_suggestions/data/datasource/local/recipe_local_datasource.dart';
import '../../features/recipe_suggestions/data/datasource/local/recipe_local_datasource_impl.dart';
import '../../features/recipe_suggestions/data/datasource/remote/recipe_remote_datasource.dart';
import '../../features/recipe_suggestions/data/datasource/remote/recipe_remote_datasource_impl.dart';
import '../../features/recipe_suggestions/data/repositories/recipe_repository_impl.dart';
import '../../features/recipe_suggestions/domain/repository/recipe_repository.dart';
import '../../features/recipe_suggestions/domain/usecases/cache_reccipe_usecase.dart';
import '../../features/recipe_suggestions/domain/usecases/generate_recipe_usecase.dart';
import '../../features/recipe_suggestions/domain/usecases/get_cached_recipes_usecase.dart';
import '../utils/firebase_auth_service.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  await _initHiveBoxes();
  _initFirebase();
  _initExternalServices();
  _initDataSources();
  _initRepositories();
  _initAuthUseCases();
  _initRecipeUseCases();
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
}

Future<void> _initHiveBoxes() async {
  await Hive.initFlutter();
  final recipeBox = await Hive.openBox('recipesBox');
  sl.registerLazySingleton<Box>(() => recipeBox);
}

void _initDataSources() {
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      firebaseAuth: sl(),
      firestore: sl(),
      googleSignIn: sl(),
    ),
  );

  sl.registerLazySingleton<RecipeRemoteDataSource>(
    () => RecipeRemoteDataSourceImpl(sl<Dio>()),
  );

  sl.registerLazySingleton<RecipeLocalDataSource>(
    () => RecipeLocalDataSourceImpl(sl<Box>()),
  );
}

void _initRepositories() {
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(networkInfo: sl(), remoteDataSource: sl()),
  );

  sl.registerLazySingleton<RecipeRepository>(
    () => RecipeRepositoryImpl(remote: sl(), local: sl()),
  );
}

void _initAuthUseCases() {
  sl.registerLazySingleton(() => CheckAuthStatusUseCase(sl()));
  sl.registerLazySingleton(() => ContinueWithGoogleUseCase(sl()));
  sl.registerLazySingleton(() => SignInUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => SignOutUseCase(sl()));
  sl.registerLazySingleton(() => DeleteAccountUseCase(sl()));
}

void _initRecipeUseCases() {
  sl.registerLazySingleton(() => GenerateRecipesUseCase(sl()));
  sl.registerLazySingleton(() => GetCachedRecipesUseCase(sl()));
  sl.registerLazySingleton(() => CacheRecipesUseCase(sl()));
}

Future<void> initCookingFeature() async {
  sl.registerFactory(
    () => CookingBloc(
      startCooking: sl(),
      updateCookingStep: sl(),
      toggleIngredient: sl(),
      completeCooking: sl(),
      getActiveSession: sl(),
    ),
  );

  sl.registerLazySingleton(() => StartCooking(sl()));
  sl.registerLazySingleton(() => UpdateCookingStep(sl()));
  sl.registerLazySingleton(() => ToggleIngredient(sl()));
  sl.registerLazySingleton(() => CompleteCooking(sl()));
  sl.registerLazySingleton(() => GetActiveSession(sl()));

  sl.registerLazySingleton<CookingRepository>(
    () => CookingRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
      authService: sl(),
    ),
  );

  // Data Sources
  sl.registerLazySingleton<CookingRemoteDataSource>(
    () => CookingRemoteDataSourceImpl(firestore: sl<FirebaseFirestore>()),
  );
}
