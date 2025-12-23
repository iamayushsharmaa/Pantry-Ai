import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../shared/models/recipe/recipe.dart';
import '../../../../shared/models/recipe/taste_preference.dart';
import '../../domain/usecases/cache_reccipe_usecase.dart';
import '../../domain/usecases/generate_recipe_usecase.dart';
import '../../domain/usecases/get_cached_recipes_usecase.dart';

part 'recipe_event.dart';
part 'recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  final GenerateRecipesUseCase generateRecipes;
  final GetCachedRecipesUseCase getCachedRecipes;
  final CacheRecipesUseCase cacheRecipes;

  RecipeBloc({
    required this.generateRecipes,
    required this.getCachedRecipes,
    required this.cacheRecipes,
  }) : super(RecipeState()) {
    on<GenerateRecipesRequested>(_onGenerateRecipes);
    on<FetchMoreRecipesRequested>(_onFetchMoreRecipes);
    on<LoadCachedRecipesRequested>(_onLoadCachedRecipes);
  }

  Future<void> _onGenerateRecipes(
    GenerateRecipesRequested event,
    Emitter<RecipeState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final recipes = await generateRecipes(
        event.imagePath,
        event.preferences,
        null,
      );

      await cacheRecipes(recipes);

      emit(
        state.copyWith(
          recipes: recipes,
          imagePath: event.imagePath,
          preferences: event.preferences,
          isLoading: false,
          error: null,
        ),
      );
    } catch (e) {
      // fallback to cached recipes
      final cached = await getCachedRecipes();

      emit(
        state.copyWith(recipes: cached, isLoading: false, error: e.toString()),
      );
    }
  }

  Future<void> _onFetchMoreRecipes(
    FetchMoreRecipesRequested event,
    Emitter<RecipeState> emit,
  ) async {
    if (state.imagePath == null || state.preferences == null) return;

    emit(state.copyWith(isLoading: true, error: null));

    try {
      final oldModels = state.recipes.toList();

      final newRecipes = await generateRecipes(
        state.imagePath!,
        state.preferences!,
        oldModels,
      );

      final updatedList = [...state.recipes, ...newRecipes];

      await cacheRecipes(updatedList);

      emit(state.copyWith(recipes: updatedList, isLoading: false, error: null));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onLoadCachedRecipes(
    LoadCachedRecipesRequested event,
    Emitter<RecipeState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final recipes = await getCachedRecipes();

      emit(state.copyWith(recipes: recipes, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
