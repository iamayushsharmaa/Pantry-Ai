import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_event.freezed.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.started() = Started;

  const factory AuthEvent.checkAuthStatus() = CheckAuthStatus;

  const factory AuthEvent.continueWithGoogle() = ContinueWithGoogle;

  const factory AuthEvent.signIn(String email, String password) = SignIn;

  const factory AuthEvent.signUp(String name, String email, String password) =
      SignUp;

  const factory AuthEvent.signOut() = SignOut;

  const factory AuthEvent.deleteAccount() = DeleteAccount;
}
