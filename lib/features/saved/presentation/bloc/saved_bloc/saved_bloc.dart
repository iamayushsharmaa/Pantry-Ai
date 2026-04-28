import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../../../../../shared/models/recipe/recipe.dart';
import '../../../../../shared/models/saved_recipe/save_recipe.dart';
import '../../../domain/usecases/get_saved_stream.dart';
import '../../../domain/usecases/toogle_saved.dart';

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
        (failure) {
          debugPrint('SavedStream failure: $failure');
        },
        (savedList) {
          debugPrint('SavedStream got ${savedList.length} recipes');
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

    result.fold((failure) {}, (_) {});
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
