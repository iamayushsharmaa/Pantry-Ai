import '../../../../core/type_def.dart';
import '../../data/repository/auth_repository.dart';
import '../entity/auth_token.dart';

class CheckAuthStatus {
  final AuthRepository repository;

  CheckAuthStatus(this.repository);

  FutureEither<AuthToken> call() async {
    return await repository.chechAuthStatus();
  }
}
