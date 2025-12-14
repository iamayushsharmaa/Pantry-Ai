part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ToggleNotifications extends SettingsEvent {
  final bool enabled;

  ToggleNotifications(this.enabled);
}

class NavigateToScreen extends SettingsEvent {
  final String screen;

  NavigateToScreen(this.screen);
}

class EditProfilePressed extends SettingsEvent {}

class LogoutRequested extends SettingsEvent {}

class LogoutConfirmed extends SettingsEvent {}

class CloseLogoutDialog extends SettingsEvent {}

class DeleteAccountRequested extends SettingsEvent {}

class DeleteAccountConfirmed extends SettingsEvent {}

class CloseDeleteDialog extends SettingsEvent {}
