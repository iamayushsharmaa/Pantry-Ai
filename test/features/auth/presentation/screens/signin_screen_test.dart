import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pantry_ai/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pantry_ai/features/auth/presentation/bloc/auth_event.dart';
import 'package:pantry_ai/features/auth/presentation/bloc/auth_state.dart';
import 'package:pantry_ai/features/auth/presentation/screens/sign_in_screen.dart';

class MockAuthBloc extends Mock implements AuthBloc {}

class FakeAuthEvent extends Fake implements AuthEvent {}

class FakeAuthState extends Fake implements AuthState {}

class MockGoRouter extends Mock implements GoRouter {}

void main() {
  late MockAuthBloc mockAuthBloc;

  setUpAll(() {
    registerFallbackValue(FakeAuthEvent());
    registerFallbackValue(FakeAuthState());
  });

  setUp(() {
    mockAuthBloc = MockAuthBloc();
    when(() => mockAuthBloc.state).thenReturn(const AuthState.initial());
    when(
      () => mockAuthBloc.stream,
    ).thenAnswer((_) => Stream<AuthState>.empty());
  });

  Widget makeTestable(Widget child) {
    return MaterialApp(
      home: BlocProvider<AuthBloc>.value(value: mockAuthBloc, child: child),
    );
  }

  testWidgets('render initial UI with buttons', (tester) async {
    when(() => mockAuthBloc.state).thenReturn(const AuthState.initial());

    await tester.pumpWidget(makeTestable(const SigninScreen()));

    expect(find.text('Sign in'), findsNWidgets(2));
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.byKey(const Key('signInButton')), findsOneWidget);

    final linkFinder = find.byWidgetPredicate(
      (widget) =>
          widget is RichText &&
          widget.text.toPlainText().contains('Don\'t have an account? '),
    );
    expect(linkFinder, findsOneWidget);

    final rich = tester.widget<RichText>(linkFinder);
    final plain = rich.text.toPlainText();
    expect(plain, contains('Sign up'));
  });

  testWidgets('validation error shown when fields invalid', (tester) async {
    when(() => mockAuthBloc.state).thenReturn(const AuthState.initial());

    await tester.pumpWidget(makeTestable(const SigninScreen()));

    final SignInButton = find.widgetWithText(ElevatedButton, 'Sign in');
    await tester.tap(SignInButton);
    await tester.pump();

    expect(find.text('Enter a valid email'), findsOneWidget);
    expect(find.text('Must be at least 6 chars'), findsOneWidget);

    verifyNever(() => mockAuthBloc.add(any()));
  });

  testWidgets('dispatches signIn event when valid credentials entered', (
    tester,
  ) async {
    when(() => mockAuthBloc.state).thenReturn(const AuthState.initial());

    await tester.pumpWidget(makeTestable(const SigninScreen()));

    await tester.enterText(find.byType(TextFormField).first, 'test@test.com');
    await tester.enterText(find.byType(TextFormField).last, '123456');
    await tester.pump();

    final signInButton = find.byKey(const Key('signInButton'));
    await tester.tap(signInButton);
    await tester.pump();

    verify(
      () => mockAuthBloc.add(AuthEvent.signIn('test@test.com', '123456')),
    ).called(1);
  });

  testWidgets('button disabled and shows Signing in… when loading', (
    tester,
  ) async {
    when(() => mockAuthBloc.state).thenReturn(const AuthState.loading());

    await tester.pumpWidget(makeTestable(const SigninScreen()));

    final loadingButton = find.widgetWithText(ElevatedButton, 'Signing in…');
    expect(loadingButton, findsOneWidget);

    await tester.tap(loadingButton);
    verifyNever(() => mockAuthBloc.add(any()));
  });

  testWidgets('navigates to signUp on tapping Sign up text', (tester) async {
    when(() => mockAuthBloc.state).thenReturn(const AuthState.initial());

    final mockRouter = MockGoRouter();
    when(() => mockRouter.pushNamed(any())).thenAnswer((_) async => {});

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<AuthBloc>.value(
          value: mockAuthBloc,
          child: Builder(
            builder: (context) {
              return InheritedGoRouter(
                goRouter: mockRouter,
                child: const SigninScreen(),
              );
            },
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('signUpLink')));
    await tester.pump();

    verify(() => mockRouter.pushNamed('signUp')).called(1);
  });
}
