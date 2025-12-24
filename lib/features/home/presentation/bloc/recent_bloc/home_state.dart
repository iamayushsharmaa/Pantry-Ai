part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeEmpty extends HomeState {
  const HomeEmpty();
}

class HomeLoaded extends HomeState {
  final List<Recipe> recipes;

  const HomeLoaded(this.recipes);

  @override
  List<Object?> get props => [recipes];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}
