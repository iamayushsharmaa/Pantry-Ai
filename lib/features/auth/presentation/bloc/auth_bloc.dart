import 'package:bloc/bloc.dart';

import '../../data/repository/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(const AuthState.initial()) {
    on<CheckAuthStatus>(_onCheckAuthStatus);
    on<ContinueWithGoogle>(_onContinueWithGoogle);
    on<SignIn>(_onSignIn);
    on<SignUp>(_onSignUp);
    on<SignOut>(_onSignOut);
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatus event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    final result = await authRepository.chechAuthStatus();
    result.fold(
      (failure) => emit(const AuthState.unauthenticated()),
      (user) => emit(AuthState.authenticated(user)), // now pass UserEntity
    );
  }

  Future<void> _onContinueWithGoogle(
    ContinueWithGoogle event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    final result = await authRepository.continueWithGoogle();
    result.fold(
      (failure) => emit(AuthState.error(failure.message)),
      (user) => emit(AuthState.authenticated(user)),
    );
  }

  Future<void> _onSignIn(SignIn event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    final result = await authRepository.signIn(event.email, event.password);
    result.fold(
      (failure) => emit(AuthState.error(failure.message)),
      (user) => emit(AuthState.authenticated(user)),
    );
  }

  Future<void> _onSignUp(SignUp event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    final result = await authRepository.register(
      event.name,
      event.email,
      event.password,
    );
    result.fold(
      (failure) => emit(AuthState.error(failure.message)),
      (user) => emit(AuthState.authenticated(user)),
    );
  }

  Future<void> _onSignOut(SignOut event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    final result = await authRepository.signOut();
    result.fold(
      (failure) => emit(AuthState.error(failure.message)),
      (_) => emit(const AuthState.unauthenticated()),
    );
  }
}
