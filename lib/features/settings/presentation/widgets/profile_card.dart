import 'package:flutter/material.dart';
import 'package:pantry_ai/features/auth/domain/entity/user_entity.dart';

import '../../../../core/theme/colors.dart';

class ProfileCard extends StatelessWidget {
  final UserEntity? user;
  final VoidCallback onEditPressed;

  const ProfileCard({
    super.key,
    required this.user,
    required this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    if (user == null) {
      return _buildLoadingCard(context);
    }

    final photoUrl = user!.profile?.photoUrl;
    final displayName = user!.name?.trim();
    final initial = (displayName != null && displayName.isNotEmpty)
        ? displayName[0].toUpperCase()
        : 'U';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: cs.onSurface.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: AppColors.brand.withOpacity(0.15),
            backgroundImage: photoUrl != null ? NetworkImage(photoUrl) : null,
            child: photoUrl == null
                ? Text(
                    initial,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.brand,
                    ),
                  )
                : null,
          ),

          const SizedBox(width: 16),

          // ───────── Name & Email ─────────
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  displayName ?? 'User',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: cs.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  user!.email,
                  style: TextStyle(
                    fontSize: 14,
                    color: cs.onSurface.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),

          Container(
            decoration: BoxDecoration(
              color: AppColors.brand.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(Icons.edit_outlined),
              color: AppColors.brand,
              onPressed: onEditPressed,
              tooltip: 'Edit Profile',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        children: [
          CircleAvatar(radius: 32),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16, width: 120),
                SizedBox(height: 8),
                SizedBox(height: 12, width: 180),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
