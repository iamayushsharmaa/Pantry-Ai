part of 'cooking_session_bloc.dart';

abstract class CookingState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CookingInitial extends CookingState {}

class CookingLoading extends CookingState {}

class CookingInProgress extends CookingState {
  final CookingSession session;

  CookingInProgress(this.session);

  @override
  List<Object?> get props => [session];
}

class CookingCompleted extends CookingState {
  final String recipeName;

  CookingCompleted(this.recipeName);

  @override
  List<Object?> get props => [recipeName];
}

class CookingError extends CookingState {
  final String message;

  CookingError(this.message);

  @override
  List<Object?> get props => [message];
}
