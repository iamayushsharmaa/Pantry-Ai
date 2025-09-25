import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pantry_ai/core/errors/failure.dart';
import 'package:pantry_ai/features/auth/data/repository/auth_repository.dart';
import 'package:pantry_ai/features/auth/domain/entity/user_entity.dart';
import 'package:pantry_ai/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pantry_ai/features/auth/presentation/bloc/auth_event.dart';
import 'package:pantry_ai/features/auth/presentation/bloc/auth_state.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late AuthBloc authBloc;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    authBloc = AuthBloc(authRepository: mockAuthRepository);
  });

  tearDown(() => authBloc.close());

  final fakeUser = UserEntity(id: '123', email: 'test@test.com');

  blocTest<AuthBloc, AuthState>(
    'emits [loading, authenticated] when CheckAuthStatus succeeds',
    build: () {
      when(
        () => mockAuthRepository.checkAuthStatus(),
      ).thenAnswer((_) async => Right(fakeUser));

      return authBloc;
    },
    act: (bloc) => bloc.add(CheckAuthStatus()),
    expect: () => [
      const AuthState.loading(),
      AuthState.authenticated(fakeUser),
    ],

    verify: (_) {
      verify(() => mockAuthRepository.checkAuthStatus()).called(1);
    },
  );

  blocTest<AuthBloc, AuthState>(
    'emits [loading, unauthenticated] when CheckAuthStatus fails',
    build: () {
      when(
        () => mockAuthRepository.checkAuthStatus(),
      ).thenAnswer((_) async => Left(Failure('Auth error')));
      return authBloc;
    },
    act: (bloc) => bloc.add(CheckAuthStatus()),
    expect: () => [const AuthState.loading(), AuthState.unauthenticated()],

    verify: (_) {
      verify(() => mockAuthRepository.checkAuthStatus()).called(1);
    },
  );

  blocTest<AuthBloc, AuthState>(
    'emits [loading, success] when ContinueWithGoogle succeeds',
    build: () {
      when(
        () => mockAuthRepository.continueWithGoogle(),
      ).thenAnswer((_) async => Right(fakeUser));
      return authBloc;
    },
    act: (bloc) => bloc.add(ContinueWithGoogle()),
    expect: () => [
      const AuthState.loading(),
      AuthState.authenticated(fakeUser),
    ],
    verify: (_) {
      verify(() => mockAuthRepository.continueWithGoogle()).called(1);
    },
  );

  blocTest<AuthBloc, AuthState>(
    'emits [loading, error] when ContinueWithGoogle fails',
    build: () {
      when(
        () => mockAuthRepository.continueWithGoogle(),
      ).thenAnswer((_) async => Left(Failure('Google error')));
      return authBloc;
    },
    act: (bloc) => bloc.add(ContinueWithGoogle()),
    expect: () => [const AuthState.loading(), AuthState.error('Google error')],
    verify: (_) {
      verify(() => mockAuthRepository.continueWithGoogle()).called(1);
    },
  );

  blocTest<AuthBloc, AuthState>(
    'emits [loading, success] when signIn succeeds',
    build: () {
      when(
        () => mockAuthRepository.signIn('test@test.com', 'password'),
      ).thenAnswer((_) async => Right(fakeUser));
      return authBloc;
    },
    act: (bloc) => bloc.add(SignIn('test@test.com', "password")),
    expect: () => [
      const AuthState.loading(),
      AuthState.authenticated(fakeUser),
    ],
  );

  blocTest<AuthBloc, AuthState>(
    'emits [loading, error] when signIn fails',
    build: () {
      when(
        () => mockAuthRepository.signIn('bad@test.com', 'wrongPassword'),
      ).thenAnswer((_) async => Left(Failure('Sign in error')));
      return authBloc;
    },
    act: (bloc) => bloc.add(SignIn('bad@test.com', "wrongPassword")),
    expect: () => [const AuthState.loading(), AuthState.error('Sign in error')],
    verify: (_) {
      verify(
        () => mockAuthRepository.signIn('bad@test.com', 'wrongPassword'),
      ).called(1);
    },
  );

  blocTest<AuthBloc, AuthState>(
    'emits [loading, success] when SignUp succeeds',
    build: () {
      when(
        () => mockAuthRepository.register('test', 'test@test.com', 'password'),
      ).thenAnswer((_) async => Right(fakeUser));
      return authBloc;
    },
    act: (bloc) => bloc.add(SignUp('test', 'test@test.com', 'password')),
    expect: () => [
      const AuthState.loading(),
      AuthState.authenticated(fakeUser),
    ],
    verify: (_) {
      verify(
        () => mockAuthRepository.register('test', 'test@test.com', 'password'),
      ).called(1);
    },
  );

  blocTest<AuthBloc, AuthState>(
    'emits [loading, error] when SignUp fails',
    build: () {
      when(
        () => mockAuthRepository.register('test', 'test@test.com', 'password'),
      ).thenAnswer((_) async => Left(Failure('Register error')));
      return authBloc;
    },
    act: (bloc) => bloc.add(SignUp('test', 'test@test.com', 'password')),
    expect: () => [
      const AuthState.loading(),
      AuthState.error('Register error'),
    ],
    verify: (_) {
      verify(
        () => mockAuthRepository.register('test', 'test@test.com', 'password'),
      ).called(1);
    },
  );

  blocTest<AuthBloc, AuthState>(
    'emits [loading, unauthenticated] when SignOut succeeds',
    build: () {
      when(
        () => mockAuthRepository.signOut(),
      ).thenAnswer((_) async => const Right(null));
      return authBloc;
    },
    act: (bloc) => bloc.add(SignOut()),
    expect: () => [
      const AuthState.loading(),
      const AuthState.unauthenticated(),
    ],
  );

  blocTest<AuthBloc, AuthState>(
    'emits [loading, error] when SignOut fails',
    build: () {
      when(
        () => mockAuthRepository.signOut(),
      ).thenAnswer((_) async => Left(Failure('Sign out fails')));
      return authBloc;
    },
    act: (bloc) => bloc.add(SignOut()),
    expect: () => [
      const AuthState.loading(),
      const AuthState.error('Sign out fails'),
    ],
  );

  blocTest<AuthBloc, AuthState>(
    'emits [loading, success] when DeleteAccount succeeds',
    build: () {
      when(
        () => mockAuthRepository.deleteAccount(),
      ).thenAnswer((_) async => Right(null));
      return authBloc;
    },
    act: (bloc) => bloc.add(DeleteAccount()),
    expect: () => [const AuthState.loading(), AuthState.unauthenticated()],
  );

  blocTest<AuthBloc, AuthState>(
    'emits [loading, error] when DeleteAccount fails',
    build: () {
      when(
        () => mockAuthRepository.deleteAccount(),
      ).thenAnswer((_) async => Left(Failure('delete error')));
      return authBloc;
    },
    act: (bloc) => bloc.add(DeleteAccount()),
    expect: () => [const AuthState.loading(), AuthState.error('delete error')],
  );
}
