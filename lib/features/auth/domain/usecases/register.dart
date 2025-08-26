
import '../../../../core/type_def.dart';
import '../../data/repository/auth_repository.dart';
import '../entity/auth_token.dart';

class Register {
  final AuthRepository repository;

  Register(this.repository);

  FutureEither<AuthToken> call(String name, String email, String password) {
    return repository.register(name, email, password);
  }
}