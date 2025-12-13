import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../../shared/models/recipe/recipe.dart';
import '../../data/model/saved_recipe_model.dart';
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
    on<ToggleSavedEvent>(_onToggleSaved);
    on<LoadSavedEvent>(_onLoadSaved);

    add(LoadSavedEvent()); // auto-load
  }

  void _onLoadSaved(LoadSavedEvent event, Emitter<SavedState> emit) async {
    await _subscription?.cancel();

    _subscription = getSavedStream().listen((savedList) {
      final ids = savedList.map((e) => e.recipeId).toSet();
      emit(state.copyWith(savedRecipes: savedList, savedRecipeIds: ids));
    });
  }

  Future<void> _onToggleSaved(
    ToggleSavedEvent event,
    Emitter<SavedState> emit,
  ) async {
    await toggleSaved(event.recipe, notes: event.notes);
    // No emit needed — stream will update via stream
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
