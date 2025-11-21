part of 'scan_bloc.dart';

@immutable
class ScanState {
  final CameraController? controller;
  final List<CameraDescription> cameras;
  final bool isFlashOn;
  final String? imagePath;
  final bool isLoading;
  final String? error;

  ScanState({
    this.controller,
    this.cameras = const [],
    this.isFlashOn = false,
    this.imagePath,
    this.isLoading = false,
    this.error,
  });

  ScanState copyWith({
    CameraController? controller,
    List<CameraDescription>? cameras,
    bool? isFlashOn,
    String? imagePath,
    bool? isLoading,
    String? error,
  }) {
    return ScanState(
      controller: controller ?? this.controller,
      cameras: cameras ?? this.cameras,
      isFlashOn: isFlashOn ?? this.isFlashOn,
      imagePath: imagePath ?? this.imagePath,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
