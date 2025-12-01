part of 'cooking_session_bloc.dart';

abstract class CookingState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CookingInitial extends CookingState {}

class CookingLoading extends CookingState {}

class CookingLoaded extends CookingState {
  final CookingSession session;
  final Recipe recipe;
  final Duration? remainingTimer;
  CookingLoaded({
    required this.session,
    required this.recipe,
    this.remainingTimer,
  });

  @override
  List<Object?> get props => [session, recipe, remainingTimer];

  CookingLoaded copyWith({Duration? remainingTimer}) => CookingLoaded(
    session: session,
    recipe: recipe,
    remainingTimer: remainingTimer ?? this.remainingTimer,
  );
}

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
