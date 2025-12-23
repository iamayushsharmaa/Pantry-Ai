import 'package:bloc/bloc.dart';

import '../../../../core/errors/failure.dart';
import '../../../../shared/models/recipe/recipe.dart';
import '../../domain/usecases/get_recipe_by_id.dart';

part 'recipe_detail_event.dart';
part 'recipe_detail_state.dart';

class RecipeDetailBloc extends Bloc<RecipeDetailEvent, RecipeDetailState> {
  final GetRecipeById getRecipeById;

  RecipeDetailBloc({required this.getRecipeById})
    : super(RecipeDetailInitial()) {
    on<LoadRecipeById>(_onLoadFromId);
    on<LoadRecipeFromMemory>(_onLoadFromMemory);
  }

  void _onLoadFromMemory(
    LoadRecipeFromMemory event,
    Emitter<RecipeDetailState> emit,
  ) {
    if (state is RecipeDetailLoading) return;
    emit(RecipeDetailLoaded(event.recipe));
  }

  Future<void> _onLoadFromId(
    LoadRecipeById event,
    Emitter<RecipeDetailState> emit,
  ) async {
    if (state is RecipeDetailLoading) return;

    emit(RecipeDetailLoading());

    final result = await getRecipeById(event.recipeId);

    result.fold(
      (failure) => emit(RecipeDetailError(_mapFailureToMessage(failure))),
      (recipe) => emit(RecipeDetailLoaded(recipe)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is NetworkFailure) {
      return 'No internet connection';
    }
    return 'Failed to load recipe';
  }
}
