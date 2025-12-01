import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pantry_ai/core/type_def.dart';
import 'package:pantry_ai/features/auth/domain/entity/user_entity.dart';
import 'package:pantry_ai/features/auth/domain/mapper/user_mapper.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../data/models/user_model.dart';
import '../../domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseFirestore _firestore;
  final fb.FirebaseAuth _firebaseAuth;
  final NetworkInfo networkInfo;

  final GoogleSignIn _googleSignIn;

  AuthRepositoryImpl({
    required FirebaseFirestore firestore,
    fb.FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
    required this.networkInfo,
  }) : _firebaseAuth = firebaseAuth ?? fb.FirebaseAuth.instance,
       _firestore = firestore,
       _googleSignIn = googleSignIn ?? GoogleSignIn();

  @override
  FutureEither<UserEntity> checkAuthStatus() async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        return Left(ServerFailure());
      }
      final model = UserModel.fromFirebaseUser(user);
      return Right(UserMapper.toEntity(model));
    } catch (e) {
      return Left(ServerFailure());
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
      await _firestore.collection('users').doc(model.uid).set(model.toJson());
      return Right(UserMapper.toEntity(model));
    } catch (e) {
      return Left(ServerFailure());
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
      return Left(ServerFailure());
    }
  }

  @override
  FutureEither<UserEntity> continueWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return Left(ServerFailure());

      final googleAuth = await googleUser.authentication;

      final credential = fb.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCred = await _firebaseAuth.signInWithCredential(credential);

      final model = UserModel.fromFirebaseUser(userCred.user!);
      await _firestore
          .collection('users')
          .doc(model.uid)
          .set(model.toJson(), SetOptions(merge: true));

      return Right(UserMapper.toEntity(model));
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  FutureEither<void> signOut() async {
    try {
      await Future.wait([_firebaseAuth.signOut(), _googleSignIn.signOut()]);
      return Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  FutureEither<void> deleteAccount() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        return Left(ServerFailure());
      }
      await _firestore.collection('users').doc(user.uid).delete();

      await user.delete();
      await _googleSignIn.signOut();

      return Right(null);
    } on fb.FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        return Left(ServerFailure());
      }
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
