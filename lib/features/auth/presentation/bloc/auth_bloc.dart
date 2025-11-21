import 'package:bloc/bloc.dart';
import 'package:pantry_ai/features/auth/domain/usecases/check_auth_status_usecase.dart';
import 'package:pantry_ai/features/auth/domain/usecases/delete_account_usecase.dart';

import '../../domain/usecases/register_usecase.dart';
import '../../domain/usecases/sign_in_google_usecase.dart';
import '../../domain/usecases/sign_in_usecase.dart';
import '../../domain/usecases/sign_out_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final CheckAuthStatusUseCase checkAuthStatus;
  final ContinueWithGoogleUseCase continueWithGoogle;
  final SignInUseCase signIn;
  final RegisterUseCase register;
  final SignOutUseCase signOut;
  final DeleteAccountUseCase deleteAccount;

  AuthBloc({
    required this.checkAuthStatus,
    required this.continueWithGoogle,
    required this.signIn,
    required this.register,
    required this.signOut,
    required this.deleteAccount,
  }) : super(const AuthState.initial()) {
    on<CheckAuthStatus>(_onCheckAuthStatus);
    on<ContinueWithGoogle>(_onContinueWithGoogle);
    on<SignIn>(_onSignIn);
    on<SignUp>(_onSignUp);
    on<SignOut>(_onSignOut);
    on<DeleteAccount>(_onDeleteAccount);
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatus event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    final result = await checkAuthStatus();
    result.fold(
      (failure) => emit(const AuthState.unauthenticated()),
      (user) => emit(AuthState.authenticated(user)),
    );
  }

  Future<void> _onContinueWithGoogle(
    ContinueWithGoogle event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    final result = await continueWithGoogle();
    result.fold(
      (failure) => emit(AuthState.error(failure.message)),
      (user) => emit(AuthState.authenticated(user)),
    );
  }

  Future<void> _onSignIn(SignIn event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    final result = await signIn(event.email, event.password);
    result.fold(
      (failure) => emit(AuthState.error(failure.message)),
      (user) => emit(AuthState.authenticated(user)),
    );
  }

  Future<void> _onSignUp(SignUp event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    final result = await register(event.name, event.email, event.password);
    result.fold(
      (failure) => emit(AuthState.error(failure.message)),
      (user) => emit(AuthState.authenticated(user)),
    );
  }

  Future<void> _onSignOut(SignOut event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    final result = await signOut();
    result.fold(
      (failure) => emit(AuthState.error(failure.message)),
      (_) => emit(const AuthState.unauthenticated()),
    );
  }

  Future<void> _onDeleteAccount(
    DeleteAccount event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    final result = await deleteAccount();
    result.fold(
      (failure) => emit(AuthState.error(failure.message)),
      (_) => emit(const AuthState.unauthenticated()),
    );
  }
}
