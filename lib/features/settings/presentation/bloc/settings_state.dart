part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  final bool isInitialLoading;
  final bool isActionLoading;
  final UserEntity? user;

  final String? errorMessage;
  final String? successMessage;

  final bool showLogoutDialog;
  final bool showDeleteDialog;

  final String? navigationTarget;
  final bool logoutSuccess;
  final bool accountDeleted;

  const SettingsState({
    this.isInitialLoading = false,
    this.isActionLoading = false,
    this.user,
    this.errorMessage,
    this.successMessage,
    this.showLogoutDialog = false,
    this.showDeleteDialog = false,
    this.navigationTarget,
    this.logoutSuccess = false,
    this.accountDeleted = false,
  });

  SettingsState copyWith({
    bool? isInitialLoading,
    bool? isActionLoading,
    UserEntity? user,
    String? errorMessage,
    String? successMessage,
    bool? showLogoutDialog,
    bool? showDeleteDialog,
    String? navigationTarget,
    bool? logoutSuccess,
    bool? accountDeleted,
  }) {
    return SettingsState(
      isInitialLoading: isInitialLoading ?? this.isInitialLoading,
      isActionLoading: isActionLoading ?? this.isActionLoading,
      user: user ?? this.user,
      errorMessage: errorMessage,
      successMessage: successMessage,
      showLogoutDialog: showLogoutDialog ?? this.showLogoutDialog,
      showDeleteDialog: showDeleteDialog ?? this.showDeleteDialog,
      navigationTarget: navigationTarget,
      logoutSuccess: logoutSuccess ?? this.logoutSuccess,
      accountDeleted: accountDeleted ?? this.accountDeleted,
    );
  }

  SettingsState clearMessages() {
    return copyWith(errorMessage: null, successMessage: null);
  }

  @override
  List<Object?> get props => [
    isInitialLoading,
    isActionLoading,
    user,
    errorMessage,
    successMessage,
    showLogoutDialog,
    showDeleteDialog,
    navigationTarget,
    logoutSuccess,
    accountDeleted,
  ];
}
