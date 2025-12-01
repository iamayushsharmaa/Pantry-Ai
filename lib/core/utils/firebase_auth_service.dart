import 'package:firebase_auth/firebase_auth.dart' as fb;

abstract class AuthService {
  String? get currentUserId;
}

class FirebaseAuthService implements AuthService {
  final fb.FirebaseAuth firebaseAuth;

  FirebaseAuthService({required this.firebaseAuth});

  @override
  String? get currentUserId => firebaseAuth.currentUser?.uid;
}
