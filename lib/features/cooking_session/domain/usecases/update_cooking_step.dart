import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecase/use_case.dart';
import '../entities/cooking_session_entity.dart';
import '../repository/cooking_repository.dart';

class UpdateCookingStep implements UseCase<CookingSession, UpdateStepParams> {
  final CookingRepository repository;

  UpdateCookingStep(this.repository);

  @override
  Future<Either<Failure, CookingSession>> call(UpdateStepParams params) async {
    final updatedSession = params.session.copyWith(
      currentStep: params.newStep,
      completedSteps: params.markComplete
          ? [...params.session.completedSteps, params.session.currentStep]
          : params.session.completedSteps,
    );

    return await repository.updateCookingSession(updatedSession);
  }
}

class UpdateStepParams extends Equatable {
  final CookingSession session;
  final int newStep;
  final bool markComplete;

  const UpdateStepParams({
    required this.session,
    required this.newStep,
    this.markComplete = true,
  });

  @override
  List<Object?> get props => [session, newStep, markComplete];
}
