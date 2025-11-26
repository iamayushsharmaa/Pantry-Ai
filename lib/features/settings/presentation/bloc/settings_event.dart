part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ToggleNotifications extends SettingsEvent {
  final bool enabled;

  ToggleNotifications(this.enabled);
}

class ToggleDarkMode extends SettingsEvent {
  final bool enabled;

  ToggleDarkMode(this.enabled);
}

class ToggleAnalytics extends SettingsEvent {
  final bool enabled;

  ToggleAnalytics(this.enabled);
}

class ChangeLanguage extends SettingsEvent {
  final String language;

  ChangeLanguage(this.language);
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
