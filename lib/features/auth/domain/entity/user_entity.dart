import 'package:pantry_ai/features/auth/domain/entity/user_profile.dart';

class UserEntity {
  final String id;
  final String email;
  final String? name;
  final UserProfile? profile;

  const UserEntity({
    required this.id,
    required this.email,
    this.name,
    this.profile,
  });

  UserEntity copyWith({String? email, String? name, UserProfile? profile}) {
    return UserEntity(
      id: id,
      email: email ?? this.email,
      name: name ?? this.name,
      profile: profile ?? this.profile,
    );
  }
}
