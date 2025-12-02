import 'package:fpdart/fpdart.dart';
import 'package:pantry_ai/features/cooking_session/domain/entities/active_cooking_data.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecase/use_case.dart';
import '../repository/cooking_repository.dart';

class GetActiveSession implements UseCase<ActiveCookingData?, String> {
  final CookingRepository repository;

  GetActiveSession(this.repository);

  @override
  Future<Either<Failure, ActiveCookingData?>> call(String recipeId) async {
    return await repository.getActiveCookingSession(recipeId);
  }
}
