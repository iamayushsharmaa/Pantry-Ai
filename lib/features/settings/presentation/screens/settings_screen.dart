import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../domain/entities/user_model.dart';
import '../widgets/profile_card.dart';
import '../widgets/section_tile.dart';
import '../widgets/setting_section.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  bool _analyticsEnabled = true;
  String _selectedLanguage = 'English';

  final User _user = User(
    name: 'Sarah Johnson',
    email: 'sarah.johnson@email.com',
    imageUrl: null,
  );

  void _navigateToEditProfile() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Navigate to Edit Profile')));
  }

  void _navigateToScreen(String screen) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Navigate to $screen')));
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Language'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ['English', 'Spanish', 'French', 'German'].map((lang) {
            return RadioListTile<String>(
              title: Text(lang),
              value: lang,
              groupValue: _selectedLanguage,
              activeColor: AppColors.brand,
              onChanged: (value) {
                setState(() => _selectedLanguage = value!);
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // TODO: Implement logout
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
          'Are you sure you want to delete your account? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // TODO: Implement account deletion
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Card
            ProfileCard(user: _user, onEditPressed: _navigateToEditProfile),
            const SizedBox(height: 24),

            // App Settings
            SettingsSection(
              title: 'App Settings',
              children: [
                SettingsTile.switchTile(
                  icon: Icons.notifications_outlined,
                  title: 'Notifications',
                  subtitle: 'Receive cooking reminders',
                  value: _notificationsEnabled,
                  onChanged: (value) {
                    setState(() => _notificationsEnabled = value);
                  },
                ),
                SettingsTile.switchTile(
                  icon: Icons.dark_mode_outlined,
                  title: 'Dark Mode',
                  subtitle: 'Enable dark theme',
                  value: _darkModeEnabled,
                  onChanged: (value) {
                    setState(() => _darkModeEnabled = value);
                  },
                ),
                SettingsTile.navigation(
                  icon: Icons.language_outlined,
                  title: 'Language',
                  subtitle: _selectedLanguage,
                  onTap: _showLanguageDialog,
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
                  onTap: () => _navigateToScreen('Dietary Restrictions'),
                ),
                SettingsTile.navigation(
                  icon: Icons.kitchen_outlined,
                  title: 'Kitchen Equipment',
                  subtitle: 'Add your available tools',
                  onTap: () => _navigateToScreen('Kitchen Equipment'),
                ),
                SettingsTile.navigation(
                  icon: Icons.favorite_outline,
                  title: 'Favorite Cuisines',
                  subtitle: 'Select preferred cuisines',
                  onTap: () => _navigateToScreen('Favorite Cuisines'),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Data & Privacy
            SettingsSection(
              title: 'Data & Privacy',
              children: [
                SettingsTile.switchTile(
                  icon: Icons.analytics_outlined,
                  title: 'Analytics',
                  subtitle: 'Help improve the app',
                  value: _analyticsEnabled,
                  onChanged: (value) {
                    setState(() => _analyticsEnabled = value);
                  },
                ),
                SettingsTile.navigation(
                  icon: Icons.download_outlined,
                  title: 'Export Data',
                  subtitle: 'Download your recipes',
                  onTap: () => _navigateToScreen('Export Data'),
                ),
                SettingsTile.navigation(
                  icon: Icons.privacy_tip_outlined,
                  title: 'Privacy Policy',
                  subtitle: 'Read our privacy policy',
                  onTap: () => _navigateToScreen('Privacy Policy'),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Support
            SettingsSection(
              title: 'Support',
              children: [
                SettingsTile.navigation(
                  icon: Icons.help_outline,
                  title: 'Help Center',
                  subtitle: 'Get help and support',
                  onTap: () => _navigateToScreen('Help Center'),
                ),
                SettingsTile.navigation(
                  icon: Icons.feedback_outlined,
                  title: 'Send Feedback',
                  subtitle: 'Share your thoughts',
                  onTap: () => _navigateToScreen('Send Feedback'),
                ),
                SettingsTile.navigation(
                  icon: Icons.star_outline,
                  title: 'Rate Us',
                  subtitle: 'Rate on App Store',
                  onTap: () => _navigateToScreen('Rate Us'),
                ),
                SettingsTile.navigation(
                  icon: Icons.info_outline,
                  title: 'About',
                  subtitle: 'Version 1.0.0',
                  onTap: () => _navigateToScreen('About'),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Account Actions
            SettingsSection(
              title: 'Account',
              children: [
                SettingsTile.navigation(
                  icon: Icons.logout,
                  title: 'Logout',
                  subtitle: 'Sign out of your account',
                  onTap: _showLogoutDialog,
                  textColor: Colors.red,
                ),
                SettingsTile.navigation(
                  icon: Icons.delete_outline,
                  title: 'Delete Account',
                  subtitle: 'Permanently delete your account',
                  onTap: _showDeleteAccountDialog,
                  textColor: Colors.red,
                ),
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
