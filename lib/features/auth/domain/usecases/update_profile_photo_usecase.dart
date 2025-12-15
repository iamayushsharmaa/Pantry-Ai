import 'dart:io';

import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/type_def.dart';
import '../../data/remote/profile_remote_datasource.dart';
import '../entity/user_entity.dart';
import '../repository/auth_repository.dart';

class UpdateProfilePhotoUseCase {
  final AuthRepository authRepository;
  final ProfileImageRemoteDataSource imageRemoteDataSource;

  UpdateProfilePhotoUseCase({
    required this.authRepository,
    required this.imageRemoteDataSource,
  });

  FutureEither<UserEntity> call(File file) async {
    try {
      final authResult = await authRepository.checkAuthStatus();

      return await authResult.fold((failure) async => Left(failure), (
        user,
      ) async {
        final photoUrl = await imageRemoteDataSource.uploadProfileImage(
          uid: user.id,
          file: file,
        );

        return authRepository.updateProfilePhoto(photoUrl);
      });
    } catch (_) {
      return Left(ServerFailure());
    }
  }
}
