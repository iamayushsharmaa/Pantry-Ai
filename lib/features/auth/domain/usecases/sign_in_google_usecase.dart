import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failure.dart';
import '../entity/user_entity.dart';
import '../repository/auth_repository.dart';

class ContinueWithGoogleUseCase {
  final AuthRepository repository;

  ContinueWithGoogleUseCase(this.repository);

  Future<Either<Failure, UserEntity>> call() {
    return repository.continueWithGoogle();
  }
}
