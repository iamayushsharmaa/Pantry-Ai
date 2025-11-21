import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'scan_event.dart';
part 'scan_state.dart';

class ScanBloc extends Bloc<ScanEvent, ScanState> {
  final ImagePicker _picker = ImagePicker();

  ScanBloc() : super(ScanState()) {
    on<InitializeCamera>(_onInitCamera);
    on<ToggleFlash>(_onToggleFlash);
    on<SwitchCamera>(_onSwitchCamera);
    on<CaptureImage>(_onCaptureImage);
    on<PickFromGallery>(_onPickFromGallery);
  }

  FutureOr<void> _onInitCamera(
    InitializeCamera event,
    Emitter<ScanState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));

      final cameras = await availableCameras();
      final camera = cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.back,
      );

      final controller = CameraController(camera, ResolutionPreset.high);

      await controller.initialize();

      emit(
        state.copyWith(
          cameras: cameras,
          controller: controller,
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(error: "Camera error: $e"));
    }
  }

  FutureOr<void> _onToggleFlash(
    ToggleFlash event,
    Emitter<ScanState> emit,
  ) async {
    if (state.controller == null) return;

    final newFlashState = !state.isFlashOn;

    await state.controller!.setFlashMode(
      newFlashState ? FlashMode.torch : FlashMode.off,
    );

    emit(state.copyWith(isFlashOn: newFlashState));
  }

  FutureOr<void> _onSwitchCamera(
    SwitchCamera event,
    Emitter<ScanState> emit,
  ) async {
    if (state.cameras.length < 2 || state.controller == null) return;

    emit(state.copyWith(isLoading: true));

    final current = state.controller!.description;

    final newCamera = current.lensDirection == CameraLensDirection.back
        ? state.cameras.firstWhere(
            (c) => c.lensDirection == CameraLensDirection.front,
          )
        : state.cameras.firstWhere(
            (c) => c.lensDirection == CameraLensDirection.back,
          );

    final controller = CameraController(newCamera, ResolutionPreset.high);

    await controller.initialize();

    emit(state.copyWith(controller: controller, isLoading: false));
  }

  FutureOr<void> _onCaptureImage(
    CaptureImage event,
    Emitter<ScanState> emit,
  ) async {
    if (state.controller == null) return;

    try {
      final XFile? file = await state.controller!.takePicture();

      emit(state.copyWith(imagePath: file!.path));
    } catch (e) {
      emit(state.copyWith(error: "Error capturing image: $e"));
    }
  }

  FutureOr<void> _onPickFromGallery(
    PickFromGallery event,
    Emitter<ScanState> emit,
  ) async {
    final XFile? file = await _picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      emit(state.copyWith(imagePath: file.path));
    }
  }
}
