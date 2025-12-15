import '../../../../core/type_def.dart';
import '../repository/auth_repository.dart';

class UpdateEmailUseCase {
  final AuthRepository repository;

  UpdateEmailUseCase(this.repository);

  FutureEither<void> call(String newEmail) {
    return repository.updateEmail(newEmail);
  }
}
