import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/app_settings/app_settings_bloc.dart';
import '../bloc/settings_bloc.dart';
import '../widgets/profile_card.dart';
import '../widgets/section_tile.dart';
import '../widgets/setting_section.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SettingsBloc(),
      child: const _SettingsView(),
    );
  }
}

class _SettingsView extends StatelessWidget {
  const _SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme
        .of(context)
        .colorScheme;

    return BlocConsumer<SettingsBloc, SettingsState>(
      listener: (context, state) {
        if (state.navigationTarget != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Navigate to ${state.navigationTarget}")),
          );
        }

        if (state.showLogoutDialog) {
          _showLogoutDialog(context);
        }

        if (state.showDeleteDialog) {
          _showDeleteAccountDialog(context);
        }
      },
      builder: (context, state) {
        final bloc = context.read<SettingsBloc>();

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
            centerTitle: false,
            backgroundColor: cs.surface,
          ),
          backgroundColor: cs.surface,
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                ProfileCard(
                  user: state.user,
                  onEditPressed: () => bloc.add(EditProfilePressed()),
                ),
                const SizedBox(height: 24),

                SettingsSection(
                  title: 'App Settings',
                  children: [
                    SettingsTile.switchTile(
                      icon: Icons.dark_mode_outlined,
                      title: 'Dark Mode',
                      subtitle: 'Enable dark theme',
                      value: Theme
                          .of(context)
                          .brightness == Brightness.dark,
                      onChanged: (enabled) {
                        context.read<AppSettingsBloc>().add(
                          ChangeThemeMode(
                            enabled ? ThemeMode.dark : ThemeMode.light,
                          ),
                        );
                      },
                    ),
                    SettingsTile.navigation(
                      icon: Icons.language_outlined,
                      title: 'Language',
                      subtitle: state.selectedLanguage,
                      onTap: () => _showLanguageDialog(context),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                SettingsSection(
                  title: 'Recipe Preferences',
                  children: [
                    SettingsTile.navigation(
                      icon: Icons.restaurant_menu_outlined,
                      title: 'Dietary Restrictions',
                      subtitle: 'Manage your diet preferences',
                      onTap: () =>
                          bloc.add(NavigateToScreen('Dietary Restrictions')),
                    ),
                    SettingsTile.navigation(
                      icon: Icons.kitchen_outlined,
                      title: 'Kitchen Equipment',
                      subtitle: 'Add your available tools',
                      onTap: () =>
                          bloc.add(NavigateToScreen('Kitchen Equipment')),
                    ),
                    SettingsTile.navigation(
                      icon: Icons.favorite_outline,
                      title: 'Favorite Cuisines',
                      subtitle: 'Select preferred cuisines',
                      onTap: () =>
                          bloc.add(NavigateToScreen('Favorite Cuisines')),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                SettingsSection(
                  title: 'Data & Privacy',
                  children: [
                    SettingsTile.navigation(
                      icon: Icons.privacy_tip_outlined,
                      title: 'Privacy Policy',
                      subtitle: 'Read our privacy policy',
                      onTap: () => bloc.add(NavigateToScreen('Privacy Policy')),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                SettingsSection(
                  title: 'Support',
                  children: [
                    SettingsTile.navigation(
                      icon: Icons.help_outline,
                      title: 'Help Center',
                      subtitle: 'Get help and support',
                      onTap: () => bloc.add(NavigateToScreen('Help Center')),
                    ),
                    SettingsTile.navigation(
                      icon: Icons.feedback_outlined,
                      title: 'Send Feedback',
                      subtitle: 'Share your thoughts',
                      onTap: () => bloc.add(NavigateToScreen('Send Feedback')),
                    ),
                    SettingsTile.navigation(
                      icon: Icons.star_outline,
                      title: 'Rate Us',
                      subtitle: 'Rate on App Store',
                      onTap: () => bloc.add(NavigateToScreen('Rate Us')),
                    ),
                    SettingsTile.navigation(
                      icon: Icons.info_outline,
                      title: 'About',
                      subtitle: 'Version 1.0.0',
                      onTap: () => bloc.add(NavigateToScreen('About')),
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
                      subtitle: 'Sign out of your account',
                      textColor: Colors.red,
                      onTap: () => bloc.add(LogoutRequested()),
                    ),
                    SettingsTile.navigation(
                      icon: Icons.delete_outline,
                      title: 'Delete Account',
                      subtitle: 'Permanently delete your account',
                      textColor: Colors.red,
                      onTap: () => bloc.add(DeleteAccountRequested()),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) =>
          AlertDialog(
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
      builder: (_) =>
          AlertDialog(
            title: const Text('Logout'),
            content: const Text('Are you sure you want to logout?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
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
      builder: (_) =>
          AlertDialog(
            title: const Text('Delete Account'),
            content: const Text(
              'Are you sure you want to delete your account permanently?',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
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