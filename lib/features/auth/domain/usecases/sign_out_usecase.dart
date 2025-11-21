import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failure.dart';
import '../repository/auth_repository.dart';

class SignOutUseCase {
  final AuthRepository repository;

  SignOutUseCase(this.repository);

  Future<Either<Failure, void>> call() {
    return repository.signOut();
  }
}
