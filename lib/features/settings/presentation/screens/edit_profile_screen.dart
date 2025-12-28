import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/image_picker_services.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/settings_bloc.dart';
import '../widgets/profile_avatar.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController _nameController;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_initialized) {
      final user = context.read<SettingsBloc>().state.user;
      _nameController = TextEditingController(text: user?.name ?? '');
      _initialized = true;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;
    final imagePicker = context.read<ImagePickerService>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.edit_profile_title,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: cs.onSurface,
          ),
        ),
      ),
      body: BlocConsumer<SettingsBloc, SettingsState>(
        listener: (context, state) {
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
          final user = state.user;

          if (user == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                ProfileAvatar(
                  photoUrl: user.profile?.photoUrl,
                  isLoading: state.isActionLoading,
                  onTap: () async {
                    final image = await imagePicker.pickImageFromGallery();
                    if (image != null && context.mounted) {
                      context.read<SettingsBloc>().add(
                        UpdateProfilePhotoRequested(image),
                      );
                    }
                  },
                ),
                const SizedBox(height: 32),

                TextField(
                  controller: _nameController,
                  style: TextStyle(color: cs.onSurface),
                  decoration: InputDecoration(
                    labelText: l10n.full_name,
                    prefixIcon: Icon(Icons.person_outline, color: cs.primary),
                    filled: true,
                    fillColor: cs.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                const SizedBox(height: 28),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: state.isActionLoading
                        ? null
                        : () {
                            final newName = _nameController.text.trim();
                            if (newName.isNotEmpty && newName != user.name) {
                              context.read<SettingsBloc>().add(
                                UpdateNameRequested(newName),
                              );
                            }
                          },
                    child: state.isActionLoading
                        ? const CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          )
                        : Text(l10n.save_changes),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
