part of 'app_settings_bloc.dart';

abstract class AppSettingsEvent {}

class ChangeThemeMode extends AppSettingsEvent {
  final ThemeMode themeMode;

  ChangeThemeMode(this.themeMode);
}

class ChangeLanguage extends AppSettingsEvent {
  final Locale locale;

  ChangeLanguage(this.locale);
}
