import '../../../../core/type_def.dart';
import '../../data/repository/auth_repository.dart';
import '../entity/auth_token.dart';

class SignIn {
  final AuthRepository repository;

  SignIn(this.repository);

  FutureEither<AuthToken> call(String email, String password) {
    return repository.signIn(email, password);
  }
}
