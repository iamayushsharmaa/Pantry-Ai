import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/auth_response.dart';
import '../models/google_signin_request.dart';
import '../models/sign_in_request.dart';
import '../models/sign_up_request.dart';

class AuthService {
  final Dio dio;
  final GoogleSignIn googleSignIn;
  final FlutterSecureStorage storage;
  static final String baseUrl = 'https://invoicely-367c.onrender.com';

  AuthService({
    required this.dio,
    required this.storage,
    GoogleSignIn? googleSignIn,
  }) : googleSignIn = googleSignIn ?? GoogleSignIn();

  Future<AuthenticationResponse> register(RegisterRequest request) async {
    try {
      final response = await dio.post(
        '/api/v1/auth/register',
        data: request.toMap(),
      );
      return AuthenticationResponse.fromJson(response.data);
    } catch (e) {
      if (e is DioException && e.response != null) {
        return AuthenticationResponse.fromJson(e.response!.data);
      }
      return AuthenticationResponse(error: 'Registration failed');
    }
  }

  Future<AuthenticationResponse> authenticate(SignInRequest request) async {
    try {
      final response = await dio.post(
        '/api/v1/auth/authenticate',
        data: request.toMap(),
      );
      return AuthenticationResponse.fromJson(response.data);
    } catch (e) {
      if (e is DioException && e.response != null) {
        return AuthenticationResponse.fromJson(e.response!.data);
      }
      return AuthenticationResponse(error: 'Sign in failed');
    }
  }

  Future<AuthenticationResponse> continueWithGoogle(
    GoogleSignInRequest request,
  ) async {
    try {
      final response = await dio.post(
        '/api/v1/auth/google',
        data: request.toJson(),
      );
      return AuthenticationResponse.fromJson(response.data);
    } catch (e) {
      if (e is DioException && e.response != null) {
        return AuthenticationResponse.fromJson(e.response!.data);
      }
      return AuthenticationResponse(error: 'Google sign-in failed');
    }
  }

  Future<String?> getToken() async {
    return await storage.read(key: 'jwt_token');
  }

  Future<void> saveToken(String token) async {
    await storage.write(key: 'jwt_token', value: token);
  }

  Future<void> clearToken() async {
    await storage.delete(key: 'jwt_token');
  }

  Future<String?> getGoogleIdToken() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return null;
      final googleAuth = await googleUser.authentication;
      return googleAuth.idToken;
    } catch (e) {
      return null;
    }
  }

  Future<void> signOutGoogle() async {
    await googleSignIn.signOut();
  }
}
