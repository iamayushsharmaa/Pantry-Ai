part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

class SettingsStarted extends SettingsEvent {}

class EditProfilePressed extends SettingsEvent {}

class UpdateNameRequested extends SettingsEvent {
  final String newName;

  const UpdateNameRequested(this.newName);

  @override
  List<Object?> get props => [newName];
}

class UpdateProfilePhotoRequested extends SettingsEvent {
  final File image;

  const UpdateProfilePhotoRequested(this.image);
}

class UpdateEmailRequested extends SettingsEvent {
  final String newEmail;

  const UpdateEmailRequested(this.newEmail);

  @override
  List<Object?> get props => [newEmail];
}

class LogoutRequested extends SettingsEvent {}

class LogoutConfirmed extends SettingsEvent {}

class CloseLogoutDialog extends SettingsEvent {}

class DeleteAccountRequested extends SettingsEvent {}

class DeleteAccountConfirmed extends SettingsEvent {}

class CloseDeleteDialog extends SettingsEvent {}

class ClearMessages extends SettingsEvent {}
