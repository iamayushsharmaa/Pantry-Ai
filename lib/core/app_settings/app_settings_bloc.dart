import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../utils/preferences.dart';

part 'app_settings_event.dart';
part 'app_settings_state.dart';

class AppSettingsBloc extends Bloc<AppSettingsEvent, AppSettingsState> {
  AppSettingsBloc()
    : super(
        const AppSettingsState(
          themeMode: ThemeMode.system,
          locale: Locale('en'),
        ),
      ) {
    _loadSavedPreferences();

    on<ChangeThemeMode>(_onChangeThemeMode);
    on<ChangeLanguage>(_onChangeLanguage);
  }

  Future<void> _loadSavedPreferences() async {
    final themeMode = await AppPreferences.getThemeMode();
    final locale = await AppPreferences.getLocale();
    add(ChangeThemeMode(themeMode));
    add(ChangeLanguage(locale));
  }

  Future<void> _onChangeThemeMode(
    ChangeThemeMode event,
    Emitter<AppSettingsState> emit,
  ) async {
    emit(state.copyWith(themeMode: event.themeMode));
    await AppPreferences.setThemeMode(event.themeMode);
  }

  Future<void> _onChangeLanguage(
    ChangeLanguage event,
    Emitter<AppSettingsState> emit,
  ) async {
    emit(state.copyWith(locale: event.locale));
    await AppPreferences.setLocale(event.locale);
  }
}
