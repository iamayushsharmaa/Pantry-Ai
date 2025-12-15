part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

class EditProfilePressed extends SettingsEvent {}

class UpdateNameRequested extends SettingsEvent {
  final String newName;

  const UpdateNameRequested(this.newName);

  @override
  List<Object?> get props => [newName];
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
