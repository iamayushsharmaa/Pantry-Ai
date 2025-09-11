import 'package:pantry_ai/features/auth/domain/entity/user_entity.dart';

import '../../../../core/type_def.dart';

abstract class AuthRepository {
  FutureEither<UserEntity> chechAuthStatus();

  FutureEither<UserEntity> register(String name, String email, String password);

  FutureEither<UserEntity> signIn(String email, String password);

  FutureEither<UserEntity> continueWithGoogle();

  FutureEither<void> signOut();

  FutureEither<void> deleteAccount();
}
