
class User {
  final String name;
  final String email;
  final String? imageUrl;

  const User({
    required this.name,
    required this.email,
    this.imageUrl,
  });

  factory User.fromFirebase(Map<String, dynamic> data) {
    return User(
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      imageUrl: data['imageUrl'],
    );
  }
}
