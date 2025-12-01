import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/cooking_session_entity.dart';
import '../../domain/usecases/complete_cooking.dart';
import '../../domain/usecases/get_active_session.dart';
import '../../domain/usecases/start_cooking.dart';
import '../../domain/usecases/toogle_ingredient.dart';
import '../../domain/usecases/update_cooking_step.dart';

part 'cooking_session_event.dart';
part 'cooking_session_state.dart';

class CookingBloc extends Bloc<CookingEvent, CookingState> {
  final StartCooking startCooking;
  final UpdateCookingStep updateCookingStep;
  final ToggleIngredient toggleIngredient;
  final CompleteCooking completeCooking;
  final GetActiveSession getActiveSession;

  CookingBloc({
    required this.startCooking,
    required this.updateCookingStep,
    required this.toggleIngredient,
    required this.completeCooking,
    required this.getActiveSession,
  }) : super(CookingInitial()) {
    on<StartCookingEvent>(_onStartCooking);
    on<LoadActiveSessionEvent>(_onLoadActiveSession);
    on<NextStepEvent>(_onNextStep);
    on<PreviousStepEvent>(_onPreviousStep);
    on<JumpToStepEvent>(_onJumpToStep);
    on<ToggleIngredientEvent>(_onToggleIngredient);
    on<CompleteCookingEvent>(_onCompleteCooking);
  }

  Future<void> _onStartCooking(
    StartCookingEvent event,
    Emitter<CookingState> emit,
  ) async {
    emit(CookingLoading());

    final result = await startCooking(
      StartCookingParams(
        recipeId: event.recipeId,
        recipeName: event.recipeName,
        totalSteps: event.totalSteps,
        ingredientIds: event.ingredientIds,
        servings: event.servings,
      ),
    );

    result.fold(
      (failure) => emit(CookingError('Failed to start cooking session')),
      (session) => emit(CookingInProgress(session)),
    );
  }

  Future<void> _onLoadActiveSession(
    LoadActiveSessionEvent event,
    Emitter<CookingState> emit,
  ) async {
    emit(CookingLoading());

    final result = await getActiveSession(event.recipeId);

    result.fold((failure) => emit(CookingError('Failed to load session')), (
      session,
    ) {
      if (session != null) {
        emit(CookingInProgress(session));
      } else {
        emit(CookingInitial());
      }
    });
  }

  Future<void> _onNextStep(
    NextStepEvent event,
    Emitter<CookingState> emit,
  ) async {
    if (state is! CookingInProgress) return;

    final currentSession = (state as CookingInProgress).session;
    if (currentSession.currentStep >= currentSession.totalSteps - 1) return;

    final result = await updateCookingStep(
      UpdateStepParams(
        session: currentSession,
        newStep: currentSession.currentStep + 1,
        markComplete: true,
      ),
    );

    result.fold(
      (failure) => emit(CookingError('Failed to update step')),
      (session) => emit(CookingInProgress(session)),
    );
  }

  Future<void> _onPreviousStep(
    PreviousStepEvent event,
    Emitter<CookingState> emit,
  ) async {
    if (state is! CookingInProgress) return;

    final currentSession = (state as CookingInProgress).session;
    if (currentSession.currentStep <= 0) return;

    final result = await updateCookingStep(
      UpdateStepParams(
        session: currentSession,
        newStep: currentSession.currentStep - 1,
        markComplete: false,
      ),
    );

    result.fold(
      (failure) => emit(CookingError('Failed to update step')),
      (session) => emit(CookingInProgress(session)),
    );
  }

  Future<void> _onJumpToStep(
    JumpToStepEvent event,
    Emitter<CookingState> emit,
  ) async {
    if (state is! CookingInProgress) return;

    final currentSession = (state as CookingInProgress).session;

    final result = await updateCookingStep(
      UpdateStepParams(
        session: currentSession,
        newStep: event.stepIndex,
        markComplete: false,
      ),
    );

    result.fold(
      (failure) => emit(CookingError('Failed to jump to step')),
      (session) => emit(CookingInProgress(session)),
    );
  }

  Future<void> _onToggleIngredient(
    ToggleIngredientEvent event,
    Emitter<CookingState> emit,
  ) async {
    if (state is! CookingInProgress) return;

    final currentSession = (state as CookingInProgress).session;

    final result = await toggleIngredient(
      ToggleIngredientParams(
        session: currentSession,
        ingredientId: event.ingredientId,
        isChecked: event.isChecked,
      ),
    );

    result.fold(
      (failure) => emit(CookingError('Failed to update ingredient')),
      (session) => emit(CookingInProgress(session)),
    );
  }

  Future<void> _onCompleteCooking(
    CompleteCookingEvent event,
    Emitter<CookingState> emit,
  ) async {
    if (state is! CookingInProgress) return;

    final currentSession = (state as CookingInProgress).session;

    final result = await completeCooking(currentSession.id);

    result.fold(
      (failure) => emit(CookingError('Failed to complete cooking')),
      (_) => emit(CookingCompleted(currentSession.recipeName)),
    );
  }
}
