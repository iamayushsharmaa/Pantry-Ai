import '../../../../core/type_def.dart';
import '../entity/user_entity.dart';
import '../repository/auth_repository.dart';

class UpdateNameUseCase {
  final AuthRepository repository;

  UpdateNameUseCase(this.repository);

  FutureEither<UserEntity> call(String newName) {
    return repository.updateName(newName);
  }
}
