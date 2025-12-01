import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecase/use_case.dart';
import '../entities/cooking_session_entity.dart';
import '../repository/cooking_repository.dart';

class GetActiveSession implements UseCase<CookingSession?, String> {
  final CookingRepository repository;

  GetActiveSession(this.repository);

  @override
  Future<Either<Failure, CookingSession?>> call(String recipeId) async {
    return await repository.getActiveCookingSession(recipeId);
  }
}
