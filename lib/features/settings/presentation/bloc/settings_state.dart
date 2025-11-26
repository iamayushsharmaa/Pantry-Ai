part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  final bool notificationsEnabled;
  final bool darkModeEnabled;
  final bool analyticsEnabled;
  final String selectedLanguage;
  final User user;

  final String? navigationTarget;

  final bool showLogoutDialog;
  final bool logoutSuccess;

  final bool showDeleteDialog;
  final bool accountDeleted;

  const SettingsState({
    required this.notificationsEnabled,
    required this.darkModeEnabled,
    required this.analyticsEnabled,
    required this.selectedLanguage,
    required this.user,
    this.navigationTarget,
    this.showLogoutDialog = false,
    this.logoutSuccess = false,
    this.showDeleteDialog = false,
    this.accountDeleted = false,
  });

  SettingsState copyWith({
    bool? notificationsEnabled,
    bool? darkModeEnabled,
    bool? analyticsEnabled,
    String? selectedLanguage,
    User? user,
    String? navigationTarget,
    bool? showLogoutDialog,
    bool? logoutSuccess,
    bool? showDeleteDialog,
    bool? accountDeleted,
  }) {
    return SettingsState(
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      darkModeEnabled: darkModeEnabled ?? this.darkModeEnabled,
      analyticsEnabled: analyticsEnabled ?? this.analyticsEnabled,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      user: user ?? this.user,
      navigationTarget: navigationTarget,
      showLogoutDialog: showLogoutDialog ?? this.showLogoutDialog,
      logoutSuccess: logoutSuccess ?? this.logoutSuccess,
      showDeleteDialog: showDeleteDialog ?? this.showDeleteDialog,
      accountDeleted: accountDeleted ?? this.accountDeleted,
    );
  }

  @override
  List<Object?> get props => [
    notificationsEnabled,
    darkModeEnabled,
    analyticsEnabled,
    selectedLanguage,
    user,
    navigationTarget,
    showLogoutDialog,
    logoutSuccess,
    showDeleteDialog,
    accountDeleted,
  ];
}
