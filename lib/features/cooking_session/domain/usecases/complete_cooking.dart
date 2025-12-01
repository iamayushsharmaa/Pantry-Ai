import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecase/use_case.dart';
import '../repository/cooking_repository.dart';

class CompleteCooking implements UseCase<void, String> {
  final CookingRepository repository;

  CompleteCooking(this.repository);

  @override
  Future<Either<Failure, void>> call(String sessionId) async {
    return await repository.completeCookingSession(sessionId);
  }
}
