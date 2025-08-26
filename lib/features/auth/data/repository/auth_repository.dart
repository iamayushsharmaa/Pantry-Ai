import '../../../../core/type_def.dart';
import '../../domain/entity/auth_token.dart';

abstract class AuthRepository {
  FutureEither<AuthToken> chechAuthStatus();

  FutureEither<AuthToken> register(String name, String email, String password);

  FutureEither<AuthToken> signIn(String email, String password);

  FutureEither<AuthToken> continueWithGoogle();

  FutureEither<void> signOut();
}
