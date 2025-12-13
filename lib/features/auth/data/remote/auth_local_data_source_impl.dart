import 'package:firebase_auth/firebase_auth.dart' as fb;

import '../../../../core/errors/exceptions.dart';
import 'auth_local_data_source.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final fb.FirebaseAuth firebaseAuth;

  AuthLocalDataSourceImpl(this.firebaseAuth);

  @override
  String get currentUserId {
    final user = firebaseAuth.currentUser;
    if (user == null) {
      throw ServerException();
    }
    return user.uid;
  }
}
