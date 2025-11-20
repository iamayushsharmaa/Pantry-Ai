import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/models/recipe_model.dart';
import '../../domain/enities/recipe_entity.dart';
import '../../domain/enities/taste_preference_entity.dart';
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
    emit(state.copyWith(isLoading: true));

    final recipes = await generateRecipes(event.imagePath, event.preferences);

    emit(
      state.copyWith(
        recipes: recipes,
        imagePath: event.imagePath,
        preferences: event.preferences,
        isLoading: false,
      ),
    );
  }

  Future<void> _onFetchMoreRecipes(
    FetchMoreRecipesRequested event,
    Emitter<RecipeState> emit,
  ) async {
    if (state.imagePath == null || state.preferences == null) return;

    emit(state.copyWith(isLoading: true));

    final oldModels = state.recipes
        .map((e) => RecipeModel.fromEntity(e))
        .toList();

    final newRecipes = await generateRecipes(
      state.imagePath!,
      state.preferences!,
      previouslySuggestedRecipes: oldModels,
    );

    final updatedList = [...state.recipes, ...newRecipes];

    await cacheRecipes(updatedList);
    emit(state.copyWith(recipes: updatedList, isLoading: false));
  }

  Future<void> _onLoadCachedRecipes(
    LoadCachedRecipesRequested event,
    Emitter<RecipeState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final recipes = await getCachedRecipes();

    emit(state.copyWith(recipes: recipes, isLoading: false));
  }
}
