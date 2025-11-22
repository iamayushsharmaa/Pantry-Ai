part of 'scan_bloc.dart';

@immutable
sealed class ScanEvent {}

class InitializeCamera extends ScanEvent {}

class DisposeCamera extends ScanEvent {}

class MarkNavigationHandled extends ScanEvent {}

class ToggleFlash extends ScanEvent {}

class SwitchCamera extends ScanEvent {}

class CaptureImage extends ScanEvent {}

class PickFromGallery extends ScanEvent {}
