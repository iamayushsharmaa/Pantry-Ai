import 'package:pantry_ai/features/auth/domain/entity/user_entity.dart';

import '../../../../core/type_def.dart';

abstract class AuthRepository {
  FutureEither<UserEntity> checkAuthStatus();

  FutureEither<UserEntity> register(String name, String email, String password);

  FutureEither<UserEntity> signIn(String email, String password);

  FutureEither<UserEntity> continueWithGoogle();

  FutureEither<UserEntity> updateName(String newName);

  FutureEither<void> updateEmail(String newEmail);

  FutureEither<void> signOut();

  FutureEither<void> deleteAccount();
}
