import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../shared/models/recipe/recipe.dart';
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
        recipeId: event.recipe.id,
        recipeName: event.recipe.title,
        totalSteps: event.recipe.instructions.length,
        ingredientIds: event.recipe.ingredients.map((e) => e.name).toList(),
        instructions: event.recipe.instructions,
        servings: event.servings,
      ),
    );

    result.fold(
      (failure) => emit(CookingError("Failed to start session")),
      (session) => emit(CookingLoaded(session: session, recipe: event.recipe)),
    );
  }

  Future<void> _onLoadActiveSession(
    LoadActiveSessionEvent event,
    Emitter<CookingState> emit,
  ) async {
    emit(CookingLoading());

    final result = await getActiveSession(event.recipeId);

    result.fold((failure) => emit(CookingError("Failed to load session")), (
      loaded,
    ) {
      if (loaded == null) {
        emit(CookingInitial());
      } else {
        emit(CookingLoaded(session: loaded.session, recipe: loaded.recipe));
      }
    });
  }

  Future<void> _onNextStep(
    NextStepEvent event,
    Emitter<CookingState> emit,
  ) async {
    if (state is! CookingLoaded) return;

    final current = state as CookingLoaded;
    final session = current.session;

    if (session.currentStep >= session.totalSteps - 1) return;

    final result = await updateCookingStep(
      UpdateStepParams(
        session: session,
        newStep: session.currentStep + 1,
        markComplete: true,
      ),
    );

    result.fold(
      (_) => emit(CookingError("Failed to update step")),
      (newSession) => emit(current.copyWith(session: newSession)),
    );
  }

  Future<void> _onPreviousStep(
    PreviousStepEvent event,
    Emitter<CookingState> emit,
  ) async {
    if (state is! CookingLoaded) return;

    final current = state as CookingLoaded;
    final session = current.session;

    if (session.currentStep <= 0) return;

    final result = await updateCookingStep(
      UpdateStepParams(
        session: session,
        newStep: session.currentStep - 1,
        markComplete: false,
      ),
    );

    result.fold(
      (_) => emit(CookingError("Failed to update step")),
      (newSession) => emit(current.copyWith(session: newSession)),
    );
  }

  Future<void> _onJumpToStep(
    JumpToStepEvent event,
    Emitter<CookingState> emit,
  ) async {
    if (state is! CookingLoaded) return;

    final current = state as CookingLoaded;
    final session = current.session;

    final result = await updateCookingStep(
      UpdateStepParams(
        session: session,
        newStep: event.stepIndex,
        markComplete: false,
      ),
    );

    result.fold(
      (_) => emit(CookingError("Failed to jump to step")),
      (newSession) => emit(current.copyWith(session: newSession)),
    );
  }

  Future<void> _onToggleIngredient(
    ToggleIngredientEvent event,
    Emitter<CookingState> emit,
  ) async {
    if (state is! CookingLoaded) return;

    final current = state as CookingLoaded;
    final session = current.session;

    final result = await toggleIngredient(
      ToggleIngredientParams(
        session: session,
        ingredientId: event.ingredientId,
        isChecked: event.isChecked,
      ),
    );

    result.fold(
      (_) => emit(CookingError("Failed to update ingredient")),
      (newSession) => emit(current.copyWith(session: newSession)),
    );
  }

  Future<void> _onCompleteCooking(
    CompleteCookingEvent event,
    Emitter<CookingState> emit,
  ) async {
    if (state is! CookingLoaded) return;

    final current = state as CookingLoaded;
    final session = current.session;

    final result = await completeCooking(session.id);

    result.fold(
      (_) => emit(CookingError("Failed to complete cooking")),
      (_) => emit(CookingCompleted(current.recipe.title)),
    );
  }
}
