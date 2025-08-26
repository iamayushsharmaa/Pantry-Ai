import 'package:fpdart/fpdart.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/type_def.dart';
import '../../data/models/google_signin_request.dart';
import '../../data/models/sign_in_request.dart';
import '../../data/models/sign_up_request.dart';
import '../../data/remote/auth_api_service.dart';
import '../../data/repository/auth_repository.dart';
import '../entity/auth_token.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService service;

  AuthRepositoryImpl(this.service);

  @override
  FutureEither<AuthToken> chechAuthStatus() async {
    try {
      final token = await service.getToken();
      if (token != null && !JwtDecoder.isExpired(token)) {
        return Right(AuthToken(token));
      }
      await service.clearToken();
      return Left(AuthFailure('No valid token found.'));
    } catch (e) {
      return Left(ServerFailure('Failed to check auth status'));
    }
  }

  @override
  FutureEither<AuthToken> continueWithGoogle() async {
    try {
      final idToken = await service.getGoogleIdToken();
      if (idToken == null) {
        return Left(AuthFailure('Google sign-in cancelled'));
      }
      final response = await service.continueWithGoogle(
        GoogleSignInRequest(token: idToken),
      );
      if (response.token != null) {
        await service.saveToken(response.token!);
        return Right(AuthToken(response.token!));
      }
      return Left(AuthFailure(response.error ?? 'Google sign-in failed'));
    } catch (e) {
      return Left(ServerFailure('Server error during Google sign-in'));
    }
  }

  @override
  FutureEither<AuthToken> register(
    String name,
    String email,
    String password,
  ) async {
    try {
      final response = await service.register(
        RegisterRequest(name: name, email: email, password: password),
      );
      if (response.token != null) {
        await service.saveToken(response.token!);
        return Right(AuthToken(response.token!));
      }
      return Left(AuthFailure(response.error ?? 'Registration failed'));
    } catch (e) {
      return Left(ServerFailure('Server error during registration'));
    }
  }

  @override
  FutureEither<AuthToken> signIn(String email, String password) async {
    try {
      final response = await service.authenticate(
        SignInRequest(email: email, password: password),
      );
      if (response.token != null) {
        await service.saveToken(response.token!);
        return Right(AuthToken(response.token!));
      }
      return Left(AuthFailure(response.error ?? 'Authentication failed'));
    } catch (e) {
      return Left(ServerFailure('Server error during sign-in'));
    }
  }

  @override
  FutureEither<void> signOut() {
    throw UnimplementedError();
  }
}
