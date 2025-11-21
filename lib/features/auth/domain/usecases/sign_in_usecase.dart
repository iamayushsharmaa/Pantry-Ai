import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failure.dart';
import '../entity/user_entity.dart';
import '../repository/auth_repository.dart';

class SignInUseCase {
  final AuthRepository repository;

  SignInUseCase(this.repository);

  Future<Either<Failure, UserEntity>> call(String email, String password) {
    return repository.signIn(email, password);
  }
}
