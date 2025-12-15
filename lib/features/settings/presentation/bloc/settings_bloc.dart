import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pantry_ai/features/auth/domain/entity/user_entity.dart';
import 'package:pantry_ai/features/auth/domain/usecases/update_email_usecase.dart';
import 'package:pantry_ai/features/auth/domain/usecases/update_name_usecase.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/utils/preferences.dart';
import '../../../auth/domain/usecases/delete_account_usecase.dart';
import '../../../auth/domain/usecases/sign_out_usecase.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final UpdateNameUseCase updateNameUseCase;
  final UpdateEmailUseCase updateEmailUseCase;
  final SignOutUseCase signOutUseCase;
  final DeleteAccountUseCase deleteAccountUseCase;

  SettingsBloc({
    required this.updateNameUseCase,
    required this.updateEmailUseCase,
    required this.signOutUseCase,
    required this.deleteAccountUseCase,
    required UserEntity initialUser,
  }) : super(
         SettingsState(
           darkModeEnabled: false,
           selectedLanguage: 'English',
           user: initialUser,
         ),
       ) {
    add(LoadSettings());
    on<ToggleDarkMode>(_onToggleDarkMode);
    on<ChangeLanguage>(_onChangeLanguage);
    on<EditProfilePressed>(_onEditProfile);
    on<UpdateNameRequested>(_onUpdateName);
    on<UpdateEmailRequested>(_onUpdateEmail);
    on<LogoutRequested>(_onLogoutRequested);
    on<LogoutConfirmed>(_onLogoutConfirmed);
    on<CloseLogoutDialog>(_onCloseLogoutDialog);
    on<DeleteAccountRequested>(_onDeleteAccountRequested);
    on<DeleteAccountConfirmed>(_onDeleteAccountConfirmed);
    on<CloseDeleteDialog>(_onCloseDeleteDialog);
    on<ClearMessages>(_onClearMessages);
  }

  Future<void> _onLoadSettings(
    LoadSettings event,
    Emitter<SettingsState> emit,
  ) async {
    final darkMode = await AppPreferences.getDarkMode();
    final language = await AppPreferences.getLanguage();

    emit(
      state
          .copyWith(darkModeEnabled: darkMode, selectedLanguage: language)
          .clearMessages(),
    );

    // Apply immediately to app
    _applyTheme(darkMode);
    _applyLanguage(language);
  }

  void _onToggleDarkMode(
    ToggleDarkMode event,
    Emitter<SettingsState> emit,
  ) async {
    final newValue = !state.darkModeEnabled;
    emit(state.copyWith(darkModeEnabled: newValue).clearMessages());

    // Save to prefs
    await AppPreferences.setDarkMode(newValue);

    // Apply to app
    _applyTheme(newValue);
  }

  void _onChangeLanguage(
    ChangeLanguage event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.copyWith(selectedLanguage: event.language).clearMessages());

    // Save to prefs
    await AppPreferences.setLanguage(event.language);

    // Apply to app
    _applyLanguage(event.language);
  }

  void _onEditProfile(EditProfilePressed event, Emitter<SettingsState> emit) {
    emit(state.copyWith(navigationTarget: 'EditProfile'));
    emit(state.copyWith(navigationTarget: null));
  }

  Future<void> _onUpdateName(
    UpdateNameRequested event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true).clearMessages());

    final result = await updateNameUseCase(event.newName);

    result.fold(
      (failure) {
        final msg = failure is ReAuthenticationFailure
            ? 'Please sign in again to update your name.'
            : 'Failed to update name. Try again.';
        emit(state.copyWith(isLoading: false, errorMessage: msg));
      },
      (updatedUser) {
        emit(
          state.copyWith(
            isLoading: false,
            user: updatedUser,
            successMessage: 'Name updated successfully!',
          ),
        );
      },
    );
  }

  Future<void> _onUpdateEmail(
    UpdateEmailRequested event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true).clearMessages());

    final result = await updateEmailUseCase(event.newEmail);

    result.fold(
      (failure) {
        final msg = failure is ReAuthenticationFailure
            ? 'Please sign in again to change email.'
            : 'Failed to send verification email.';
        emit(state.copyWith(isLoading: false, errorMessage: msg));
      },
      (_) {
        emit(
          state.copyWith(
            isLoading: false,
            successMessage:
                'Verification email sent to ${event.newEmail}.\nCheck your inbox!',
          ),
        );
      },
    );
  }

  void _onLogoutRequested(LogoutRequested event, Emitter<SettingsState> emit) {
    emit(state.copyWith(showLogoutDialog: true));
  }

  Future<void> _onLogoutConfirmed(
    LogoutConfirmed event,
    Emitter<SettingsState> emit,
  ) async {
    emit(
      state.copyWith(isLoading: true, showLogoutDialog: false).clearMessages(),
    );

    final result = await signOutUseCase();

    result.fold(
      (failure) => emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Logout failed. Please try again.',
        ),
      ),
      (_) => emit(state.copyWith(isLoading: false, logoutSuccess: true)),
    );
  }

  void _onCloseLogoutDialog(
    CloseLogoutDialog event,
    Emitter<SettingsState> emit,
  ) {
    emit(state.copyWith(showLogoutDialog: false));
  }

  void _onDeleteAccountRequested(
    DeleteAccountRequested event,
    Emitter<SettingsState> emit,
  ) {
    emit(state.copyWith(showDeleteDialog: true));
  }

  Future<void> _onDeleteAccountConfirmed(
    DeleteAccountConfirmed event,
    Emitter<SettingsState> emit,
  ) async {
    emit(
      state.copyWith(isLoading: true, showDeleteDialog: false).clearMessages(),
    );

    final result = await deleteAccountUseCase();

    result.fold((failure) {
      final msg = failure is ReAuthenticationFailure
          ? 'Please sign in again to delete your account.'
          : 'Failed to delete account.';
      emit(state.copyWith(isLoading: false, errorMessage: msg));
    }, (_) => emit(state.copyWith(isLoading: false, accountDeleted: true)));
  }

  void _onCloseDeleteDialog(
    CloseDeleteDialog event,
    Emitter<SettingsState> emit,
  ) {
    emit(state.copyWith(showDeleteDialog: false));
  }

  void _onClearMessages(ClearMessages event, Emitter<SettingsState> emit) {
    emit(state.clearMessages());
  }
}
