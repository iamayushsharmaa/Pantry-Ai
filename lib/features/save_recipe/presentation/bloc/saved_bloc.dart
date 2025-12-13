import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../../shared/models/recipe/recipe.dart';
import '../../domain/entities/save_recipe_entity.dart';
import '../../domain/usecases/get_saved_stream.dart';
import '../../domain/usecases/toogle_saved.dart';

part 'saved_event.dart';
part 'saved_state.dart';

class SavedBloc extends Bloc<SavedEvent, SavedState> {
  final ToggleSaved toggleSaved;
  final GetSavedStream getSavedStream;

  StreamSubscription? _subscription;

  SavedBloc({required this.toggleSaved, required this.getSavedStream})
    : super(SavedState.initial()) {
    on<LoadSavedEvent>(_onLoadSaved);
    on<ToggleSavedEvent>(_onToggleSaved);
    on<_SavedStreamUpdated>(_onSavedUpdated);

    add(LoadSavedEvent());
  }

  Future<void> _onLoadSaved(
    LoadSavedEvent event,
    Emitter<SavedState> emit,
  ) async {
    await _subscription?.cancel();

    _subscription = getSavedStream().listen((either) {
      either.fold(
        (_) {
          // optional: emit error state
        },
        (savedList) {
          add(_SavedStreamUpdated(savedList));
        },
      );
    });
  }

  void _onSavedUpdated(_SavedStreamUpdated event, Emitter<SavedState> emit) {
    final ids = event.recipes.map((e) => e.recipeId).toSet();

    emit(state.copyWith(savedRecipes: event.recipes, savedRecipeIds: ids));
  }

  Future<void> _onToggleSaved(
    ToggleSavedEvent event,
    Emitter<SavedState> emit,
  ) async {
    final result = await toggleSaved(event.recipe, notes: event.notes);

    result.fold((failure) {
      // optional: emit error / snackbar
    }, (_) {});
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
