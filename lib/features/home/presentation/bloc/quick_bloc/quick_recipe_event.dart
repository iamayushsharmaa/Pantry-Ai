part of 'quick_recipe_bloc.dart';

abstract class QuickRecipesEvent extends Equatable {
  const QuickRecipesEvent();

  @override
  List<Object?> get props => [];
}

class LoadQuickRecipes extends QuickRecipesEvent {
  const LoadQuickRecipes();
}
