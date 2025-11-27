import 'package:bloc/bloc.dart';

import '../../../../shared/models/recipe/recipe.dart';
import '../../domain/usecases/get_recipe_by_id.dart';

part 'recipe_detail_event.dart';
part 'recipe_detail_state.dart';

class RecipeDetailBloc extends Bloc<RecipeDetailEvent, RecipeDetailState> {
  final GetRecipeById getRecipeById;

  RecipeDetailBloc({required this.getRecipeById})
    : super(RecipeDetailInitial()) {
    on<LoadRecipeDetail>(_onLoadRecipe);
  }

  Future<void> _onLoadRecipe(
    LoadRecipeDetail event,
    Emitter<RecipeDetailState> emit,
  ) async {
    emit(RecipeDetailLoading());
    final result = await getRecipeById(event.recipeId);

    result.fold(
      (failure) => emit(RecipeDetailError('Failed to load recipe')),
      (recipe) => emit(RecipeDetailLoaded(recipe)),
    );
  }
}
