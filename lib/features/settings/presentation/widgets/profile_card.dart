import 'package:flutter/material.dart';
import 'package:pantry_ai/features/auth/domain/entity/user_entity.dart';

import '../../../../core/theme/colors.dart';

class ProfileCard extends StatelessWidget {
  final UserEntity user;
  final VoidCallback onEditPressed;

  const ProfileCard({
    super.key,
    required this.user,
    required this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
        ),
      ),
      child: Row(
        children: [
          // Profile Picture
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              // gradient: user.imageUrl == null
              //     ? const LinearGradient(
              //         colors: [Color(0xFF00A87D), Color(0xFF00C896)],
              //       )
              //     : null,
              // image: user.imageUrl != null
              //     ? DecorationImage(
              //         image: NetworkImage(user.imageUrl!),
              //         fit: BoxFit.cover,
              //       )
              //     : null,
            ),
            //   child: user.imageUrl == null
            //       ? Center(
            //           child: Text(
            //             user.name.isNotEmpty ? user.name[0].toUpperCase() : 'U',
            //             style: const TextStyle(
            //               fontSize: 28,
            //               fontWeight: FontWeight.bold,
            //               color: Colors.white,
            //             ),
            //           ),
            //         )
            //       : null,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.email,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  user.email,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.6),
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
}
