import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/errors/exceptions.dart';
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
  }) : super(const RecipeState()) {
    on<GenerateRecipesRequested>(_onGenerateRecipes);
    on<FetchMoreRecipesRequested>(_onFetchMoreRecipes);
    on<LoadCachedRecipesRequested>(_onLoadCachedRecipes);
  }

  Future<void> _onGenerateRecipes(
    GenerateRecipesRequested event,
    Emitter<RecipeState> emit,
  ) async {
    debugPrint('🚀 GenerateRecipesRequested fired');
    debugPrint('   imagePath: ${event.imagePath}');
    debugPrint('   preferences: ${event.preferences}');

    emit(
      state.copyWith(
        status: RecipeStatus.loading,
        imagePath: event.imagePath,
        preferences: event.preferences,
      ),
    );
    try {
      final recipes = await generateRecipes(
        event.imagePath,
        event.preferences,
        null,
      );

      emit(
        state.copyWith(
          status: RecipeStatus.success,
          recipes: recipes,
          imagePath: event.imagePath,
          preferences: event.preferences,
          fetchCount: 0,
          hasReachedMax: false,
          error: null,
        ),
      );
    } catch (e, stack) {
      if (e is NoGroceriesDetectedException) {
        emit(
          state.copyWith(
            status: RecipeStatus.noGroceries,
            imagePath: event.imagePath,
            preferences: event.preferences,
          ),
        );
        return;
      }

      try {
        final cached = await getCachedRecipes();
        emit(
          state.copyWith(
            status: cached.isEmpty
                ? RecipeStatus.failure
                : RecipeStatus.success,
            recipes: cached,
            imagePath: event.imagePath,
            preferences: event.preferences,
            error: e.toString(),
            retryCount: state.retryCount + 1,
          ),
        );
      } catch (cacheError) {
        emit(
          state.copyWith(
            status: RecipeStatus.failure,
            error: e.toString(),
            imagePath: event.imagePath,
            preferences: event.preferences,
          ),
        );
      }
    }
  }

  Future<void> _onFetchMoreRecipes(
    FetchMoreRecipesRequested event,
    Emitter<RecipeState> emit,
  ) async {
    if (!state.canFetchMore) {
      emit(state.copyWith(hasReachedMax: true));
      return;
    }

    if (state.imagePath == null || state.preferences == null) return;

    emit(state.copyWith(status: RecipeStatus.loading));

    try {
      final newRecipes = await generateRecipes(
        state.imagePath!,
        state.preferences!,
        state.recipes.toList(),
      );

      final updatedList = [...state.recipes, ...newRecipes];
      final newFetchCount = state.fetchCount + 1;

      emit(
        state.copyWith(
          status: RecipeStatus.success,
          recipes: updatedList,
          fetchCount: newFetchCount,
          hasReachedMax:
              newFetchCount >= RecipeState.maxFetches ||
              updatedList.length >= RecipeState.maxRecipes,
          error: null,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: RecipeStatus.success, error: e.toString()));
    }
  }

  Future<void> _onLoadCachedRecipes(
    LoadCachedRecipesRequested event,
    Emitter<RecipeState> emit,
  ) async {
    emit(state.copyWith(status: RecipeStatus.loading));

    try {
      final recipes = await getCachedRecipes();
      emit(state.copyWith(status: RecipeStatus.success, recipes: recipes));
    } catch (e) {
      emit(state.copyWith(status: RecipeStatus.failure, error: e.toString()));
    }
  }
}
