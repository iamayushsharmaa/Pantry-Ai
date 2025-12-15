import '../../data/models/user_model.dart';
import '../entity/user_entity.dart';
import '../entity/user_profile.dart';

extension UserModelMapper on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      id: uid,
      email: email,
      name: displayName,
      profile: photoUrl != null ? UserProfile(photoUrl: photoUrl) : null,
    );
  }
}
