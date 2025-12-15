import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pantry_ai/core/router/app_route_names.dart';

import '../../../../core/app_settings/app_settings_bloc.dart';
import '../bloc/settings_bloc.dart';
import '../widgets/profile_card.dart';
import '../widgets/section_tile.dart';
import '../widgets/setting_section.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return BlocProvider(
      create: (_) => context.read<SettingsBloc>()..add(SettingsStarted()),
      child: BlocConsumer<SettingsBloc, SettingsState>(
        listener: (context, state) {
          if (state.showLogoutDialog) {
            _showLogoutDialog(context);
          }

          if (state.showDeleteDialog) {
            _showDeleteAccountDialog(context);
          }

          if (state.logoutSuccess || state.accountDeleted) {
            context.goNamed(AppRouteNames.onboarding);
          }

          if (state.errorMessage != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }

          if (state.successMessage != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.successMessage!)));
          }
        },
        builder: (context, state) {
          final bloc = context.read<SettingsBloc>();

          if (state.isLoading && state.user == null) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          final user = state.user!;

          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Settings',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: cs.onSurface,
                ),
              ),
              backgroundColor: cs.surface,
            ),
            backgroundColor: cs.surface,
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  ProfileCard(
                    user: user,
                    onEditPressed: () => bloc.add(EditProfilePressed()),
                  ),
                  const SizedBox(height: 24),

                  SettingsSection(
                    title: 'App Settings',
                    children: [
                      BlocBuilder<AppSettingsBloc, AppSettingsState>(
                        builder: (context, appState) {
                          return SettingsTile.switchTile(
                            icon: Icons.dark_mode_outlined,
                            title: 'Dark Mode',
                            subtitle: 'Enable dark theme',
                            value: appState.themeMode == ThemeMode.dark,
                            onChanged: (enabled) {
                              context.read<AppSettingsBloc>().add(
                                ChangeThemeMode(
                                  enabled ? ThemeMode.dark : ThemeMode.light,
                                ),
                              );
                            },
                          );
                        },
                      ),
                      SettingsTile.navigation(
                        icon: Icons.language_outlined,
                        title: 'Language',
                        onTap: () => _showLanguageDialog(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  SettingsSection(
                    title: 'Account',
                    children: [
                      SettingsTile.navigation(
                        icon: Icons.logout,
                        title: 'Logout',
                        textColor: Colors.red,
                        onTap: () => bloc.add(LogoutRequested()),
                      ),
                      SettingsTile.navigation(
                        icon: Icons.delete_outline,
                        title: 'Delete Account',
                        textColor: Colors.red,
                        onTap: () => bloc.add(DeleteAccountRequested()),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Select Language'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _languageTile(context, 'English', const Locale('en')),
            _languageTile(context, 'Hindi', const Locale('hi')),
            _languageTile(context, 'Spanish', const Locale('es')),
          ],
        ),
      ),
    );
  }

  Widget _languageTile(BuildContext context, String label, Locale locale) {
    return ListTile(
      title: Text(label),
      onTap: () {
        context.read<AppSettingsBloc>().add(ChangeLanguage(locale));
        Navigator.pop(context);
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    final bloc = context.read<SettingsBloc>();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              bloc.add(LogoutConfirmed());
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    final bloc = context.read<SettingsBloc>();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
          'Are you sure you want to delete your account permanently?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              bloc.add(DeleteAccountConfirmed());
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
