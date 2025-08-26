class GoogleSignInRequest {
  final String token;

  GoogleSignInRequest({required this.token});

  Map<String, dynamic> toJson() => {'token': token};
}