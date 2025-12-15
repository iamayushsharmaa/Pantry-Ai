part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadSettings extends SettingsEvent {}

class ToggleDarkMode extends SettingsEvent {}

class ChangeLanguage extends SettingsEvent {
  final String language;

  ChangeLanguage(this.language);
}

class EditProfilePressed extends SettingsEvent {}

class UpdateNameRequested extends SettingsEvent {
  final String newName;

  UpdateNameRequested(this.newName);
}

class UpdateEmailRequested extends SettingsEvent {
  final String newEmail;

  UpdateEmailRequested(this.newEmail);
}

class LogoutRequested extends SettingsEvent {}

class LogoutConfirmed extends SettingsEvent {}

class CloseLogoutDialog extends SettingsEvent {}

class DeleteAccountRequested extends SettingsEvent {}

class DeleteAccountConfirmed extends SettingsEvent {}

class CloseDeleteDialog extends SettingsEvent {}

class ClearMessages extends SettingsEvent {}
