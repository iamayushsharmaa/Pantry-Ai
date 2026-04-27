part of 'saved_bloc.dart';

abstract class SavedEvent {}

class ToggleSavedEvent extends SavedEvent {
  final Recipe recipe;
  final String? notes;

  ToggleSavedEvent(this.recipe, {this.notes});
}

class LoadSavedEvent extends SavedEvent {}

class _SavedStreamUpdated extends SavedEvent {
  final List<SavedRecipe> recipes;

  _SavedStreamUpdated(this.recipes);
}

