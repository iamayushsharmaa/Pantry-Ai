part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  final UserEntity user;

  final bool isLoading;
  final String? errorMessage;
  final String? successMessage;

  final bool showLogoutDialog;
  final bool showDeleteDialog;

  final String? navigationTarget;
  final bool logoutSuccess;
  final bool accountDeleted;

  const SettingsState({
    required this.user,
    this.isLoading = false,
    this.errorMessage,
    this.successMessage,
    this.showLogoutDialog = false,
    this.showDeleteDialog = false,
    this.navigationTarget,
    this.logoutSuccess = false,
    this.accountDeleted = false,
  });

  SettingsState copyWith({
    UserEntity? user,
    bool? isLoading,
    String? errorMessage,
    String? successMessage,
    bool? showLogoutDialog,
    bool? showDeleteDialog,
    String? navigationTarget,
    bool? logoutSuccess,
    bool? accountDeleted,
  }) {
    return SettingsState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
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
    user,
    isLoading,
    errorMessage,
    successMessage,
    showLogoutDialog,
    showDeleteDialog,
    navigationTarget,
    logoutSuccess,
    accountDeleted,
  ];
}
