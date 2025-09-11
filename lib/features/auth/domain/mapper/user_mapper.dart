import 'package:firebase_auth/firebase_auth.dart' as fb;

import '../../data/models/user_model.dart';
import '../entity/user_entity.dart';

class UserMapper {
  static UserModel fromFirebaseUser(fb.User user) {
    return UserModel(
      uid: user.uid,
      email: user.email ?? '',
      displayName: user.displayName,
    );
  }

  static UserEntity toEntity(UserModel model) {
    return UserEntity(
      id: model.uid,
      email: model.email,
      name: model.displayName,
    );
  }
}
