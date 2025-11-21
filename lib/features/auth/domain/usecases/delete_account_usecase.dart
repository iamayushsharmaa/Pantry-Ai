import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failure.dart';
import '../repository/auth_repository.dart';

class DeleteAccountUseCase {
  final AuthRepository repository;

  DeleteAccountUseCase(this.repository);

  Future<Either<Failure, void>> call() {
    return repository.deleteAccount();
  }
}
