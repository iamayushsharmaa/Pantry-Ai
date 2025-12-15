import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> checkAuthStatus();

  Future<UserModel> register(String name, String email, String password);

  Future<UserModel> signIn(String email, String password);

  Future<UserModel> continueWithGoogle();

  Future<UserModel> updateName(String newName);

  Future<void> updateEmail(String newEmail);

  Future<UserModel> updateProfilePhoto(String photoUrl);

  Future<void> signOut();

  Future<void> deleteAccount();
}
