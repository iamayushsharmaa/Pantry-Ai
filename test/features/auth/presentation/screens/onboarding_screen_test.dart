import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pantry_ai/core/router/router.dart';
import 'package:pantry_ai/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pantry_ai/features/auth/presentation/bloc/auth_event.dart';
import 'package:pantry_ai/features/auth/presentation/bloc/auth_state.dart';
import 'package:pantry_ai/features/auth/presentation/screens/onboarding_screen.dart';
import 'package:pantry_ai/features/auth/presentation/screens/sign_in_screen.dart';

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

class FakeAuthEvent extends Fake implements AuthEvent {}

class FakeAuthState extends Fake implements AuthState {}

void main() {
  late MockAuthBloc mockAuthBloc;

  setUpAll(() {
    registerFallbackValue(FakeAuthEvent());
    registerFallbackValue(FakeAuthState());
  });

  setUp(() {
    mockAuthBloc = MockAuthBloc();
  });

  testWidgets('render initial UI with buttons', (tester) async {
    when(() => mockAuthBloc.state).thenReturn(const AuthState.initial());

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<AuthBloc>.value(
          value: mockAuthBloc,
          child: const OnBoardingScreen(),
        ),
      ),
    );

    expect(find.text('PANTRY AI.'), findsOneWidget);
    expect(find.text('Continue with Google'), findsOneWidget);
    expect(find.text('Continue with Email'), findsOneWidget);
  });

  testWidgets('dispatches ContinueWithGoogle when Google button pressed', (
    tester,
  ) async {
    when(() => mockAuthBloc.state).thenReturn(const AuthState.initial());

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<AuthBloc>.value(
          value: mockAuthBloc,
          child: OnBoardingScreen(),
        ),
      ),
    );

    await tester.tap(find.text('Continue with Google'));
    await tester.pump();

    verify(() => mockAuthBloc.add(AuthEvent.continueWithGoogle())).called(1);
  });

  testWidgets('Google button disabled and shows Signing in... when loading', (
    tester,
  ) async {
    when(() => mockAuthBloc.state).thenReturn(const AuthState.loading());

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<AuthBloc>.value(
          value: mockAuthBloc,
          child: OnBoardingScreen(),
        ),
      ),
    );

    final button = find.text('Signing in...');

    expect(button, findsOneWidget);

    await tester.tap(button);
    verifyNever(() => mockAuthBloc.add(any()));
  });

  testWidgets('shows SnackBar when error state emitted', (tester) async {
    whenListen(
      mockAuthBloc,
      Stream.fromIterable([
        const AuthState.initial(),
        const AuthState.error('Something went wrong'),
      ]),
      initialState: const AuthState.initial(),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<AuthBloc>.value(
          value: mockAuthBloc,
          child: const OnBoardingScreen(),
        ),
      ),
    );

    await tester.pump();
    await tester.pump();

    expect(find.text('Something went wrong'), findsOneWidget);
  });

  testWidgets('navigates to EmailSignInScreen on tap', (tester) async {
    when(() => mockAuthBloc.state).thenReturn(const AuthState.initial());

    final router = appRouter;
    router.go('/onboarding');
    await tester.pumpWidget(
      BlocProvider<AuthBloc>.value(
        value: mockAuthBloc,
        child: MaterialApp.router(routerConfig: router),
      ),
    );

    await tester.pumpAndSettle();

    await tester.tap(find.text('Continue with Email'));
    await tester.pumpAndSettle();

    expect(find.byType(SigninScreen), findsOneWidget);
  });
}
