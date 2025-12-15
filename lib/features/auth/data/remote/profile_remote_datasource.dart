import 'dart:io';

abstract class ProfileImageRemoteDataSource {
  Future<String> uploadProfileImage({required String uid, required File file});
}
