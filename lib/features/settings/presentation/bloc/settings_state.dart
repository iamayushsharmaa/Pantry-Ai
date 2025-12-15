part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  final bool darkModeEnabled;
  final String selectedLanguage;

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
    required this.darkModeEnabled,
    required this.selectedLanguage,
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
    bool? notificationsEnabled,
    bool? darkModeEnabled,
    bool? analyticsEnabled,
    String? selectedLanguage,
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
      darkModeEnabled: darkModeEnabled ?? this.darkModeEnabled,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
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

  // Helper to clear messages
  SettingsState clearMessages() {
    return copyWith(errorMessage: null, successMessage: null);
  }

  @override
  List<Object?> get props => [
    darkModeEnabled,
    selectedLanguage,
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
