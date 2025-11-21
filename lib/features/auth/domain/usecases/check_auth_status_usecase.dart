import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failure.dart';
import '../entity/user_entity.dart';
import '../repository/auth_repository.dart';

class CheckAuthStatusUseCase {
  final AuthRepository repository;

  CheckAuthStatusUseCase(this.repository);

  Future<Either<Failure, UserEntity>> call() {
    return repository.checkAuthStatus();
  }
}
