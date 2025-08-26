class User {
  final String id;
  final String email;
  final String name;
  final String? profileImageUrl;
  final String token;

  User({required this.id, required this.email, required this.name, required this.profileImageUrl, required this.token});

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'email': this.email,
      'name': this.name,
      'profileImageUrl': this.profileImageUrl,
      'token': this.token,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      email: map['email'] as String,
      name: map['name'] as String,
      profileImageUrl: map['profileImageUrl'] as String,
      token: map['token'] as String,
    );
  }
}