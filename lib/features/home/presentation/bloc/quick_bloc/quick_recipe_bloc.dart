import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/models/recipe/recipe.dart';
import '../../../../auth/domain/usecases/check_auth_status_usecase.dart';
import '../../../domain/usecases/get_quick_recipe_usecase.dart';

part 'quick_recipe_event.dart';
part 'quick_recipe_state.dart';

class QuickRecipesBloc extends Bloc<QuickRecipesEvent, QuickRecipesState> {
  final CheckAuthStatusUseCase checkAuthStatus;
  final GetQuickRecipesUseCase getQuickRecipes;

  QuickRecipesBloc({
    required this.checkAuthStatus,
    required this.getQuickRecipes,
  }) : super(QuickRecipesLoading()) {
    on<LoadQuickRecipes>(_onLoad);
  }

  Future<void> _onLoad(
    LoadQuickRecipes event,
    Emitter<QuickRecipesState> emit,
  ) async {
    emit(QuickRecipesLoading());

    final authResult = await checkAuthStatus();

    authResult.fold((_) => emit(QuickRecipesEmpty()), (user) async {
      final recipes = await getQuickRecipes(user.id);

      if (recipes.isEmpty) {
        emit(QuickRecipesEmpty());
      } else {
        emit(QuickRecipesLoaded(recipes));
      }
    });
  }
}
