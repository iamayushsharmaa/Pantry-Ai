import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pantry_ai/core/type_def.dart';
import 'package:pantry_ai/features/auth/domain/entity/user_entity.dart';
import 'package:pantry_ai/features/auth/domain/mapper/user_mapper.dart';

import '../../../../core/errors/failure.dart';
import '../../data/models/user_model.dart';
import '../../data/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseFirestore _firestore;
  final fb.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthRepositoryImpl({
    required FirebaseFirestore firestore,
    fb.FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  }) : _firebaseAuth = firebaseAuth ?? fb.FirebaseAuth.instance,
       _firestore = firestore,
       _googleSignIn = googleSignIn ?? GoogleSignIn();

  @override
  FutureEither<UserEntity> chechAuthStatus() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        return Left(Failure('No user logged in'));
      }
      final model = UserModel.fromFirebaseUser(user);
      return Right(UserMapper.toEntity(model));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  FutureEither<UserEntity> register(
    String name,
    String email,
    String password,
  ) async {
    try {
      final cred = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await cred.user?.updateDisplayName(name);

      final model = UserModel.fromFirebaseUser(cred.user!);
      return Right(UserMapper.toEntity(model));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  FutureEither<UserEntity> signIn(String email, String password) async {
    try {
      final cred = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final model = UserModel.fromFirebaseUser(cred.user!);
      return Right(UserMapper.toEntity(model));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  FutureEither<UserEntity> continueWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return Left(Failure('Cancelled by user'));

      final googleAuth = await googleUser.authentication;

      final credential = fb.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCred = await _firebaseAuth.signInWithCredential(credential);

      final model = UserModel.fromFirebaseUser(userCred.user!);
      return Right(UserMapper.toEntity(model));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  FutureEither<void> signOut() async {
    try {
      await Future.wait([_firebaseAuth.signOut(), _googleSignIn.signOut()]);
      return Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
