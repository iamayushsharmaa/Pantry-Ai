import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> checkAuthStatus();

  Future<UserModel> register(String name, String email, String password);

  Future<UserModel> signIn(String email, String password);

  Future<UserModel> continueWithGoogle();

  Future<void> signOut();

  Future<void> deleteAccount();
}
