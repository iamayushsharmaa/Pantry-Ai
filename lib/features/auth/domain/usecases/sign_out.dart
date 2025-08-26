import '../../../../core/type_def.dart';
import '../../data/repository/auth_repository.dart';

class SignOut {
  final AuthRepository repository;

  SignOut(this.repository);

  FutureVoid call() async {
    return await repository.signOut();
  }
}
