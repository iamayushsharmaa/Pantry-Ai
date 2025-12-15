import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pantry_ai/features/auth/domain/entity/user_entity.dart';
import 'package:pantry_ai/features/auth/domain/usecases/update_email_usecase.dart';
import 'package:pantry_ai/features/auth/domain/usecases/update_name_usecase.dart';

import '../../../../core/errors/failure.dart';
import '../../../auth/domain/usecases/check_auth_status_usecase.dart';
import '../../../auth/domain/usecases/delete_account_usecase.dart';
import '../../../auth/domain/usecases/sign_out_usecase.dart';
import '../../../auth/domain/usecases/update_profile_photo_usecase.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final CheckAuthStatusUseCase checkAuthStatusUseCase;
  final UpdateNameUseCase updateNameUseCase;
  final UpdateEmailUseCase updateEmailUseCase;
  final UpdateProfilePhotoUseCase updateProfilePhotoUseCase;
  final SignOutUseCase signOutUseCase;
  final DeleteAccountUseCase deleteAccountUseCase;

  SettingsBloc({
    required this.checkAuthStatusUseCase,
    required this.updateNameUseCase,
    required this.updateEmailUseCase,
    required this.signOutUseCase,
    required this.deleteAccountUseCase,
    required this.updateProfilePhotoUseCase,
  }) : super(const SettingsState(isLoading: true)) {
    on<SettingsStarted>(_onStarted);
    on<EditProfilePressed>(_onEditProfile);
    on<UpdateNameRequested>(_onUpdateName);
    on<UpdateEmailRequested>(_onUpdateEmail);
    on<UpdateProfilePhotoRequested>(_onUpdateProfilePhoto);
    on<LogoutRequested>(_onLogoutRequested);
    on<LogoutConfirmed>(_onLogoutConfirmed);
    on<CloseLogoutDialog>(_onCloseLogoutDialog);
    on<DeleteAccountRequested>(_onDeleteAccountRequested);
    on<DeleteAccountConfirmed>(_onDeleteAccountConfirmed);
    on<CloseDeleteDialog>(_onCloseDeleteDialog);
    on<ClearMessages>(_onClearMessages);
  }

  Future<void> _onStarted(
    SettingsStarted event,
    Emitter<SettingsState> emit,
  ) async {
    final result = await checkAuthStatusUseCase();

    result.fold(
      (_) => emit(
        state.copyWith(isLoading: false, errorMessage: 'Not authenticated'),
      ),
      (user) => emit(state.copyWith(isLoading: false, user: user)),
    );
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
        final message = failure is ReAuthenticationFailure
            ? 'Please sign in again to update your name.'
            : 'Failed to update name. Try again.';
        emit(state.copyWith(isLoading: false, errorMessage: message));
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
        final message = failure is ReAuthenticationFailure
            ? 'Please sign in again to change email.'
            : 'Failed to send verification email.';
        emit(state.copyWith(isLoading: false, errorMessage: message));
      },
      (_) {
        emit(
          state.copyWith(
            isLoading: false,
            successMessage:
                'Verification email sent to ${event.newEmail}. Check your inbox.',
          ),
        );
      },
    );
  }

  Future<void> _onUpdateProfilePhoto(
    UpdateProfilePhotoRequested event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true).clearMessages());

    final result = await updateProfilePhotoUseCase(event.image);

    result.fold(
      (failure) => emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to update profile photo',
        ),
      ),
      (updatedUser) => emit(
        state.copyWith(
          isLoading: false,
          user: updatedUser,
          successMessage: 'Profile photo updated',
        ),
      ),
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
      (_) => emit(
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
      final message = failure is ReAuthenticationFailure
          ? 'Please sign in again to delete your account.'
          : 'Failed to delete account.';
      emit(state.copyWith(isLoading: false, errorMessage: message));
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
