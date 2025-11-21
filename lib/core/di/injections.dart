import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:pantry_ai/features/auth/data/repository/auth_repository.dart';
import 'package:pantry_ai/features/auth/domain/repository/auth_repository_impl.dart';

import '../../features/recipe_suggestions/data/datasource/local/recipe_local_datasource.dart';
import '../../features/recipe_suggestions/data/datasource/local/recipe_local_datasource_impl.dart';
import '../../features/recipe_suggestions/data/datasource/remote/recipe_remote_datasource.dart';
import '../../features/recipe_suggestions/data/datasource/remote/recipe_remote_datasource_impl.dart';
import '../../features/recipe_suggestions/data/repositories/recipe_repository_impl.dart';
import '../../features/recipe_suggestions/domain/repository/recipe_repository.dart';
import '../../features/recipe_suggestions/domain/usecases/cache_reccipe_usecase.dart';
import '../../features/recipe_suggestions/domain/usecases/generate_recipe_usecase.dart';
import '../../features/recipe_suggestions/domain/usecases/get_cached_recipes_usecase.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  _initFirebase();
  _initExternalServices();
  await _initHiveBoxes();
  _initDataSources();
  _initRepositories();
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
}

Future<void> _initHiveBoxes() async {
  final recipeBox = await Hive.openBox('recipesBox');
  sl.registerLazySingleton<Box>(() => recipeBox);
}

void _initDataSources() {
  sl.registerLazySingleton<RecipeRemoteDataSource>(
    () => RecipeRemoteDataSourceImpl(sl<Dio>()),
  );

  sl.registerLazySingleton<RecipeLocalDataSource>(
    () => RecipeLocalDataSourceImpl(sl<Box>()),
  );
}

void _initRepositories() {
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      firestore: sl(),
      firebaseAuth: sl(),
      googleSignIn: sl(),
    ),
  );

  sl.registerLazySingleton<RecipeRepository>(
    () => RecipeRepositoryImpl(remote: sl(), local: sl()),
  );
}

void _initRecipeUseCases() {
  sl.registerLazySingleton(() => GenerateRecipesUseCase(sl()));
  sl.registerLazySingleton(() => GetCachedRecipesUseCase(sl()));
  sl.registerLazySingleton(() => CacheRecipesUseCase(sl()));
}
