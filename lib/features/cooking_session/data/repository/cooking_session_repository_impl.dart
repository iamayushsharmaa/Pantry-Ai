import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/cooking_session_entity.dart';
import '../../domain/repository/cooking_repository.dart';
import '../datasource/cooking_session_datasources.dart';
import '../models/cooking_session_model.dart';

class CookingRepositoryImpl implements CookingRepository {
  final CookingRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  final String userId;

  CookingRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
    required this.userId,
  });

  @override
  Future<Either<Failure, CookingSession>> startCookingSession({
    required String recipeId,
    required String recipeName,
    required int totalSteps,
    required List<String> ingredientIds,
    required int servings,
  }) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }

    try {
      final session = await remoteDataSource.startCookingSession(
        userId: userId,
        recipeId: recipeId,
        recipeName: recipeName,
        totalSteps: totalSteps,
        ingredientIds: ingredientIds,
        servings: servings,
      );
      return Right(session);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, CookingSession>> updateCookingSession(
    CookingSession session,
  ) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }

    try {
      final model = CookingSessionModel.fromEntity(session);
      final updated = await remoteDataSource.updateCookingSession(
        userId,
        model,
      );
      return Right(updated);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> completeCookingSession(String sessionId) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }

    try {
      await remoteDataSource.completeCookingSession(userId, sessionId);
      return const Right(null);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, CookingSession?>> getActiveCookingSession(
    String recipeId,
  ) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }

    try {
      final session = await remoteDataSource.getActiveCookingSession(
        userId,
        recipeId,
      );
      return Right(session);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<CookingSession>>> getCookingHistory({
    int limit = 20,
  }) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }

    try {
      final sessions = await remoteDataSource.getCookingHistory(
        userId,
        limit: limit,
      );
      return Right(sessions);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
