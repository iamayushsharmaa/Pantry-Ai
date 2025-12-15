import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:pantry_ai/features/auth/data/remote/profile_remote_datasource.dart';

class ProfileImageRemoteDataSourceImpl implements ProfileImageRemoteDataSource {
  final FirebaseStorage storage;

  ProfileImageRemoteDataSourceImpl(this.storage);

  @override
  Future<String> uploadProfileImage({
    required String uid,
    required File file,
  }) async {
    final ref = storage.ref('users/$uid/profile.jpg');
    await ref.putFile(file);
    return await ref.getDownloadURL();
  }
}
