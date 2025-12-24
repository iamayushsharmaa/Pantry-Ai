import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/models/recipe/recipe.dart';
import '../../../domain/usecases/get_recent_recipe_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetRecentRecipesUseCase getRecentRecipes;

  HomeBloc({required this.getRecentRecipes}) : super(const HomeLoading()) {
    on<LoadRecentRecipes>(_onLoadRecentRecipes);
  }

  Future<void> _onLoadRecentRecipes(
    LoadRecentRecipes event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoading());

    try {
      final recipes = await getRecentRecipes();

      if (recipes.isEmpty) {
        emit(const HomeEmpty());
      } else {
        emit(HomeLoaded(recipes));
      }
    } catch (_) {
      emit(const HomeError('Failed to load recent recipes'));
    }
  }
}
