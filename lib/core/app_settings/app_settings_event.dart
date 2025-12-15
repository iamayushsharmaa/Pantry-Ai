part of 'app_settings_bloc.dart';

abstract class AppSettingsEvent extends Equatable {
  const AppSettingsEvent();

  @override
  List<Object?> get props => [];
}

class ChangeThemeMode extends AppSettingsEvent {
  final ThemeMode themeMode;

  const ChangeThemeMode(this.themeMode);

  @override
  List<Object?> get props => [themeMode];
}

class ChangeLanguage extends AppSettingsEvent {
  final Locale locale;

  const ChangeLanguage(this.locale);

  @override
  List<Object?> get props => [locale];
}
