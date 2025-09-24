import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pantry_ai/core/errors/failure.dart';
import 'package:pantry_ai/features/auth/domain/repository/auth_repository_impl.dart';

class MockFirestore extends Mock implements FirebaseFirestore {}

class MockFirebaseAuth extends Mock implements fb.FirebaseAuth {}

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

class MockUser extends Mock implements fb.User {}

class MockUserCredential extends Mock implements fb.UserCredential {}

class MockGoogleSignInAccount extends Mock implements GoogleSignInAccount {}

class MockGoogleSignInAuthentication extends Mock
    implements GoogleSignInAuthentication {}

class MockDocumentReference extends Mock
    implements DocumentReference<Map<String, dynamic>> {}

class MockCollectionReference extends Mock
    implements CollectionReference<Map<String, dynamic>> {}

void main() {
  late MockFirestore firestore;
  late MockFirebaseAuth firebaseAuth;
  late MockGoogleSignIn googleSignIn;
  late AuthRepositoryImpl repository;
  late MockUserCredential mockUserCredential;
  late MockUser mockUser;
  late MockCollectionReference mockCollection;
  late MockDocumentReference mockDoc;
  late MockGoogleSignInAccount mockGoogleSignInAccount;
  late MockGoogleSignInAuthentication mockGoogleSignInAuthentication;

  setUp(() {
    firestore = MockFirestore();
    firebaseAuth = MockFirebaseAuth();
    googleSignIn = MockGoogleSignIn();
    repository = AuthRepositoryImpl(
      firestore: firestore,
      firebaseAuth: firebaseAuth,
      googleSignIn: googleSignIn,
    );

    mockUserCredential = MockUserCredential();
    mockUser = MockUser();
    mockCollection = MockCollectionReference();
    mockDoc = MockDocumentReference();
    mockGoogleSignInAccount = MockGoogleSignInAccount();
    mockGoogleSignInAuthentication = MockGoogleSignInAuthentication();
  });

  group('AuthRepositoryImpl', () {
    group('signIn', () {
      test('signIn returns Right(UserEntity) on success', () async {
        when(
          () => firebaseAuth.signInWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => mockUserCredential);

        when(() => mockUserCredential.user).thenReturn(mockUser);
        when(() => mockUser.uid).thenReturn('123');
        when(() => mockUser.email).thenReturn('test@example.com');

        final result = await repository.signIn('test@example.com', 'password');

        expect(result.isRight(), true);
        verify(
          () => firebaseAuth.signInWithEmailAndPassword(
            email: 'test@example.com',
            password: 'password',
          ),
        ).called(1);
      });

      test('signIn returns Left(Failure) on exception', () async {
        when(
          () => firebaseAuth.signInWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(Exception('Firebase error'));

        final result = await repository.signIn('bas@test.com', 'password');

        expect(result.isLeft(), true);
      });
    });

    group('register', () {
      test('returns Right(UserEntity) on success', () async {
        when(
          () => firebaseAuth.createUserWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => mockUserCredential);

        when(() => mockUserCredential.user).thenReturn(mockUser);
        when(
          () => mockUser.updateDisplayName(any()),
        ).thenAnswer((_) async => Future.value());

        when(() => mockUser.uid).thenReturn('123');
        when(() => mockUser.email).thenReturn('test@test.com');
        when(() => mockUser.displayName).thenReturn('Ayush');

        when(() => firestore.collection('users')).thenReturn(mockCollection);
        when(() => mockCollection.doc('123')).thenReturn(mockDoc);
        when(() => mockDoc.set(any())).thenAnswer((_) async {});

        final result = await repository.register(
          'Ayush',
          'test@test.com',
          'password',
        );

        expect(result.isRight(), true);

        verify(
          () => firebaseAuth.createUserWithEmailAndPassword(
            email: 'test@test.com',
            password: 'password',
          ),
        ).called(1);
        verify(() => mockUser.updateDisplayName('Ayush')).called(1);
        verify(() => mockDoc.set(any())).called(1);
      });

      test('returns Left(Failure) on exception', () async {
        when(
          () => firebaseAuth.createUserWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(Exception('Firebase error'));

        final result = await repository.register(
          'Ayush',
          'bad@test.com',
          'password',
        );

        expect(result.isLeft(), true);

        result.fold((failure) {
          expect(failure, isA<Failure>());
          expect(failure.message, contains('Firebase error'));
        }, (r) {});
      });
    });

    group('checkAuthStatus', () {
      test('returns Right(UserEntity) when user logged in', () async {
        when(() => firebaseAuth.currentUser).thenReturn(mockUser);
        when(() => mockUser.uid).thenReturn('123');
        when(() => mockUser.email).thenReturn('test@test.com');

        final result = await repository.chechAuthStatus();

        expect(result.isRight(), true);
      });

      test('returns Left(Failure) when no user logged in', () async {
        when(() => firebaseAuth.currentUser).thenReturn(null);

        final result = await repository.chechAuthStatus();

        expect(result.isLeft(), true);
      });
    });

    group('continueWithGoogle', () {
      test('continueWithGoogle returns Right(UserEntity) on success', () async {
        when(() => googleSignIn.signIn())
            .thenAnswer((_) async => mockGoogleSignInAccount);

        when(() => mockGoogleSignInAccount.authentication)
            .thenAnswer((_) async => mockGoogleSignInAuthentication);

        when(() => mockGoogleSignInAuthentication.accessToken)
            .thenReturn('token123');

        when(() => mockGoogleSignInAuthentication.idToken)
            .thenReturn('id123');

        when(() => firebaseAuth.signInWithCredential(any()))
            .thenAnswer((_) async => mockUserCredential);

        when(() => mockUserCredential.user).thenReturn(mockUser);
        when(() => mockUser.uid).thenReturn('uid123');
        when(() => mockUser.email).thenReturn('test@test.com');
        when(() => mockUser.displayName).thenReturn('Test User');

        when(() => firestore.collection('users'))
            .thenReturn(mockCollection);

        when(() => mockCollection.doc('uid123'))
            .thenReturn(mockDoc);

        when(() => mockDoc.set(any(), any()))
            .thenAnswer((_) async {});

        final result = await repository.continueWithGoogle();

        expect(result.isRight(), true);

        verify(() => googleSignIn.signIn()).called(1);
        verify(() => firebaseAuth.signInWithCredential(any())).called(1);
        verify(() => mockDoc.set(any(), any())).called(1);
      });


      test('returns Left(Failure) when user cancels Google sign in', () async {
        when(() => googleSignIn.signIn()).thenThrow(Exception('error'));
        final result = await repository.continueWithGoogle();
        expect(result.isLeft(), true);
      });

      test('returns Left(Failure) on exception', () async {
        when(() => googleSignIn.signIn()).thenThrow(Exception('error'));

        final result = await repository.continueWithGoogle();

        expect(result.isLeft(), true);
      });
    });

    group('signOut', () {
      test('returns Right(null) on success', () async {
        when(() => firebaseAuth.signOut()).thenAnswer((_) async {});
        when(() => googleSignIn.signOut()).thenAnswer((_) async {});

        final result = await repository.signOut();

        expect(result.isRight(), true);

        verify(() => firebaseAuth.signOut()).called(1);
        verify(() => googleSignIn.signOut()).called(1);
      });

      test('returns Left(Failure) on exception', () async {
        when(() => firebaseAuth.signOut()).thenThrow(Exception('error'));
        when(() => googleSignIn.signOut()).thenAnswer((_) async => null);

        final result = await repository.signOut();

        expect(result.isLeft(), true);
      });
    });

    group('deleteAccount', () {
      test('returns Right(null) on success', () async {
        when(() => firebaseAuth.currentUser).thenReturn(mockUser);
        when(() => mockUser.uid).thenReturn('123');
        when(() => firestore.collection('users')).thenReturn(mockCollection);
        when(() => mockCollection.doc('123')).thenReturn(mockDoc);
        when(() => mockDoc.delete()).thenAnswer((_) async => {});
        when(() => mockUser.delete()).thenAnswer((_) async => {});
        when(() => googleSignIn.signOut()).thenAnswer((_) async => null);

        final result = await repository.deleteAccount();

        expect(result.isRight(), true);
      });

      test('returns Left(Failure) when no user logged in', () async {
        when(() => firebaseAuth.currentUser).thenReturn(null);

        final result = await repository.deleteAccount();

        expect(result.isLeft(), true);
      });

      test(
        'returns Left(Failure) on FirebaseAuthException requires-recent-login',
        () async {
          when(() => firebaseAuth.currentUser).thenReturn(mockUser);
          when(() => mockUser.uid).thenReturn('123');
          when(() => firestore.collection('users')).thenReturn(mockCollection);
          when(() => mockCollection.doc('123')).thenReturn(mockDoc);
          when(() => mockDoc.delete()).thenAnswer((_) async {});
          when(
            () => mockUser.delete(),
          ).thenThrow(fb.FirebaseAuthException(code: 'requires-recent-login'));

          final result = await repository.deleteAccount();

          expect(result.isLeft(), true);
        },
      );
    });
  });
}
