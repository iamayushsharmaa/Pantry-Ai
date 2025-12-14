import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

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
    on<ChangeThemeMode>((event, emit) {
      emit(state.copyWith(themeMode: event.themeMode));
    });

    on<ChangeLanguage>((event, emit) {
      emit(state.copyWith(locale: event.locale));
    });
  }
}
