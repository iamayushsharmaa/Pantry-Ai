import 'dart:io';

import 'package:image_picker/image_picker.dart';

abstract class ImagePickerService {
  Future<File?> pickImageFromGallery();

  Future<File?> pickImageFromCamera();
}

class ImagePickerServiceImpl implements ImagePickerService {
  final ImagePicker _picker = ImagePicker();

  @override
  Future<File?> pickImageFromGallery() async {
    final result = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    return result != null ? File(result.path) : null;
  }

  @override
  Future<File?> pickImageFromCamera() async {
    final result = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
    );
    return result != null ? File(result.path) : null;
  }
}
