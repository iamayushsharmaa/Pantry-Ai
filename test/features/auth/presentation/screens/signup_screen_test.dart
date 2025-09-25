import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pantry_ai/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pantry_ai/features/auth/presentation/bloc/auth_event.dart';
import 'package:pantry_ai/features/auth/presentation/bloc/auth_state.dart';
import 'package:pantry_ai/features/auth/presentation/screens/sign_up_screen.dart';

class MockAuthBloc extends Mock implements AuthBloc {}

class FakeAuthEvent extends Fake implements AuthEvent {}

class FakeAuthState extends Fake implements AuthState {}

class MockGoRouter extends Mock implements GoRouter {}

void main() {
  late MockAuthBloc mockAuthBloc;
  late GoRouter mockRouter;

  setUpAll(() {
    registerFallbackValue(FakeAuthEvent());
    registerFallbackValue(FakeAuthState());
  });

  setUp(() {
    mockAuthBloc = MockAuthBloc();
    mockRouter = MockGoRouter();

    when(() => mockAuthBloc.state).thenReturn(const AuthState.initial());
    when(() => mockAuthBloc.stream).thenAnswer((_) => const Stream.empty());
  });

  Widget makeTestable(Widget child) {
    return MaterialApp(
      home: BlocProvider<AuthBloc>.value(
        value: mockAuthBloc,
        child: Builder(
          builder: (context) {
            return child;
          },
        ),
      ),
    );
  }

  testWidgets('renders all fields and button', (tester) async {
    await tester.pumpWidget(makeTestable(const SignupScreen()));

    expect(find.text('Sign up').first, findsOneWidget);
    expect(find.text('Name'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Sign up'), findsOneWidget);

    final linkFinder = find.byWidgetPredicate(
          (widget) =>
      widget is RichText &&
          widget.text.toPlainText().contains('Already have an account? '),
    );
    expect(linkFinder, findsOneWidget);

    final rich = tester.widget<RichText>(linkFinder);
    final plain = rich.text.toPlainText();
    expect(plain, contains('Sign in'));
  });

  testWidgets('dispatches signUp event when valid inputs entered', (
    tester,
  ) async {
    await tester.pumpWidget(makeTestable(const SignupScreen()));

    await tester.enterText(find.byType(TextFormField).at(0), 'John Doe');
    await tester.enterText(find.byType(TextFormField).at(1), 'test@test.com');
    await tester.enterText(find.byType(TextFormField).at(2), '123456');

    final signUpButton = find.widgetWithText(ElevatedButton, 'Sign up');
    await tester.tap(signUpButton);
    await tester.pump();

    verify(
      () => mockAuthBloc.add(
        AuthEvent.signUp('John Doe', 'test@test.com', '123456'),
      ),
    ).called(1);
  });

  testWidgets('shows CircularProgressIndicator when loading', (tester) async {
    when(() => mockAuthBloc.state).thenReturn(const AuthState.loading());
    await tester.pumpWidget(makeTestable(const SignupScreen()));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('shows snackbar on error', (tester) async {
    whenListen(
      mockAuthBloc,
      Stream<AuthState>.fromIterable([const AuthState.error('Oops')]),
      initialState: const AuthState.initial(),
    );

    await tester.pumpWidget(makeTestable(const SignupScreen()));
    await tester.pumpAndSettle(); // Wait for the listener to show the snackbar

    expect(find.text('Oops'), findsOneWidget);
  });

  testWidgets('tapping Sign in pops navigation', (tester) async {
    bool popped = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Navigator(
          onPopPage: (route, result) {
            popped = true;
            return route.didPop(result);
          },
          pages: [MaterialPage(child: makeTestable(const SignupScreen()))],
        ),
      ),
    );

    await tester.tap(find.text('Sign in'));
    await tester.pumpAndSettle();

    expect(popped, isTrue);
  });
}
