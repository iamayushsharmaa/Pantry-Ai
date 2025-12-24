part of 'quick_recipe_bloc.dart';

abstract class QuickRecipesState extends Equatable {
  const QuickRecipesState();

  @override
  List<Object?> get props => [];
}

class QuickRecipesLoading extends QuickRecipesState {}

class QuickRecipesEmpty extends QuickRecipesState {}

class QuickRecipesLoaded extends QuickRecipesState {
  final List<Recipe> recipes;

  const QuickRecipesLoaded(this.recipes);

  @override
  List<Object?> get props => [recipes];
}

class QuickRecipesError extends QuickRecipesState {}
