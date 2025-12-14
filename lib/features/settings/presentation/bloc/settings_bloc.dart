import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/user_model.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc()
    : super(
        SettingsState(
          notificationsEnabled: true,
          darkModeEnabled: false,
          analyticsEnabled: true,
          selectedLanguage: 'English',
          user: const User(
            name: 'Sarah Johnson',
            email: 'sarah.johnson@email.com',
            imageUrl: null,
          ),
        ),
      ) {
    on<ToggleNotifications>((event, emit) {
      emit(state.copyWith(notificationsEnabled: event.enabled));
    });

    on<NavigateToScreen>((event, emit) {
      emit(state.copyWith(navigationTarget: event.screen));
      emit(state.copyWith(navigationTarget: null)); // reset
    });

    on<EditProfilePressed>((event, emit) {
      emit(state.copyWith(navigationTarget: "EditProfile"));
      emit(state.copyWith(navigationTarget: null));
    });

    on<LogoutRequested>((event, emit) {
      emit(state.copyWith(showLogoutDialog: true));
    });

    on<LogoutConfirmed>((event, emit) {
      emit(state.copyWith(showLogoutDialog: false, logoutSuccess: true));
    });

    on<CloseLogoutDialog>((event, emit) {
      emit(state.copyWith(showLogoutDialog: false));
    });

    on<DeleteAccountRequested>((event, emit) {
      emit(state.copyWith(showDeleteDialog: true));
    });

    on<DeleteAccountConfirmed>((event, emit) {
      emit(state.copyWith(showDeleteDialog: false, accountDeleted: true));
    });

    on<CloseDeleteDialog>((event, emit) {
      emit(state.copyWith(showDeleteDialog: false));
    });
  }
}
