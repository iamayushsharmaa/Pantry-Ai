class SignInRequest {
  final String email;
  final String password;

  SignInRequest({required this.email, required this.password});

  Map<String, dynamic> toMap() {
    return {'email': this.email, 'password': this.password};
  }

  factory SignInRequest.fromMap(Map<String, dynamic> map) {
    return SignInRequest(
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }
}