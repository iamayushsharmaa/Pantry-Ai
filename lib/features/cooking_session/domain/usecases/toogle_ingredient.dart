import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecase/use_case.dart';
import '../entities/cooking_session_entity.dart';
import '../repository/cooking_repository.dart';

class ToggleIngredient
    implements UseCase<CookingSession, ToggleIngredientParams> {
  final CookingRepository repository;

  ToggleIngredient(this.repository);

  @override
  Future<Either<Failure, CookingSession>> call(
    ToggleIngredientParams params,
  ) async {
    final updatedChecklist = Map<String, bool>.from(
      params.session.ingredientChecklist,
    );
    updatedChecklist[params.ingredientId] = params.isChecked;

    final updatedSession = params.session.copyWith(
      ingredientChecklist: updatedChecklist,
    );

    return await repository.updateCookingSession(updatedSession);
  }
}

class ToggleIngredientParams extends Equatable {
  final CookingSession session;
  final String ingredientId;
  final bool isChecked;

  const ToggleIngredientParams({
    required this.session,
    required this.ingredientId,
    required this.isChecked,
  });

  @override
  List<Object?> get props => [session, ingredientId, isChecked];
}
