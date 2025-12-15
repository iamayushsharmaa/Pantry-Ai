import 'package:fpdart/fpdart.dart';
import 'package:pantry_ai/core/type_def.dart';
import 'package:pantry_ai/features/auth/domain/entity/user_entity.dart';
import 'package:pantry_ai/features/auth/domain/mapper/user_mapper.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repository/auth_repository.dart';
import '../remote/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, UserEntity>> checkAuthStatus() async {
    if (!await networkInfo.isConnected) return Left(NetworkFailure());

    try {
      final model = await remoteDataSource.checkAuthStatus();
      return Right(model.toEntity());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> register(
    String name,
    String email,
    String password,
  ) async {
    try {
      final model = await remoteDataSource.register(name, email, password);
      return Right(model.toEntity());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signIn(
    String email,
    String password,
  ) async {
    try {
      final model = await remoteDataSource.signIn(email, password);
      return Right(model.toEntity());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> continueWithGoogle() async {
    try {
      final model = await remoteDataSource.continueWithGoogle();
      return Right(model.toEntity());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await remoteDataSource.signOut();
      return const Right(null);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteAccount() async {
    try {
      await remoteDataSource.deleteAccount();
      return const Right(null);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> updateName(String newName) async {
    try {
      final userModel = await remoteDataSource.updateName(newName);
      return Right(userModel as UserEntity);
    } on ReAuthenticationRequiredException {
      return Left(ReAuthenticationFailure());
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  FutureEither<void> updateEmail(String newEmail) async {
    try {
      await remoteDataSource.updateEmail(newEmail);
      return Right(null);
    } on ReAuthenticationRequiredException {
      return Left(ReAuthenticationFailure());
    } on ServerException catch (e) {
      print(e);
      return Left(ServerFailure());
    } catch (e) {
      print(e);
      return Left(ServerFailure());
    }
  }
}
