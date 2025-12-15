import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failure.dart';
import '../../../auth/domain/entity/user_entity.dart';
import '../../../auth/domain/usecases/update_name_usecase.dart' as auth;

class UpdateNameUseCase {
  final auth.UpdateNameUseCase authUpdateName;

  UpdateNameUseCase(this.authUpdateName);

  Future<Either<Failure, UserEntity>> call(String newName) {
    return authUpdateName(newName);
  }
}
