import 'package:firebase_auth/firebase_auth.dart' as fb;

class UserModel {
  final String uid;
  final String email;
  final String? displayName;

  UserModel({required this.uid, required this.email, this.displayName});

  factory UserModel.fromFirebaseUser(fb.User user) {
    return UserModel(
      uid: user.uid,
      email: user.email ?? '',
      displayName: user.displayName,
    );
  }

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'email': email,
    'displayName': displayName,
  };
}
