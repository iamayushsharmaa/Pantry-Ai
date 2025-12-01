import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/user_model.dart';
import 'auth_remote_datasource.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final fb.FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;
  final GoogleSignIn googleSignIn;

  AuthRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.firestore,
    required this.googleSignIn,
  });

  @override
  Future<UserModel> checkAuthStatus() async {
    final user = firebaseAuth.currentUser;

    if (user == null) throw ServerException();

    return UserModel.fromFirebaseUser(user);
  }

  @override
  Future<UserModel> register(String name, String email, String password) async {
    try {
      final cred = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await cred.user?.updateDisplayName(name);

      final model = UserModel.fromFirebaseUser(cred.user!);
      await firestore.collection('users').doc(model.uid).set(model.toJson());

      return model;
    } catch (_) {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> signIn(String email, String password) async {
    try {
      final cred = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final model = UserModel.fromFirebaseUser(cred.user!);
      return model;
    } catch (_) {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> continueWithGoogle() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) throw ServerException();

      final auth = await googleUser.authentication;

      final credential = fb.GoogleAuthProvider.credential(
        accessToken: auth.accessToken,
        idToken: auth.idToken,
      );

      final userCred = await firebaseAuth.signInWithCredential(credential);
      final model = UserModel.fromFirebaseUser(userCred.user!);

      await firestore
          .collection('users')
          .doc(model.uid)
          .set(model.toJson(), SetOptions(merge: true));

      return model;
    } catch (_) {
      throw ServerException();
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await Future.wait([firebaseAuth.signOut(), googleSignIn.signOut()]);
    } catch (_) {
      throw ServerException();
    }
  }

  @override
  Future<void> deleteAccount() async {
    try {
      final user = firebaseAuth.currentUser;
      if (user == null) throw ServerException();

      await firestore.collection('users').doc(user.uid).delete();
      await user.delete();
      await googleSignIn.signOut();
    } catch (_) {
      throw ServerException();
    }
  }
}
