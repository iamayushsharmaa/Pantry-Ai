import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String? photoUrl;
  final VoidCallback onTap;
  final bool isLoading;

  const ProfileAvatar({
    required this.photoUrl,
    required this.onTap,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        GestureDetector(
          onTap: isLoading ? null : onTap,
          child: CircleAvatar(
            radius: 56,
            backgroundColor: cs.primary.withOpacity(0.15),
            backgroundImage: photoUrl != null ? NetworkImage(photoUrl!) : null,
            child: photoUrl == null
                ? Icon(Icons.person, size: 56, color: cs.primary)
                : null,
          ),
        ),

        Container(
          decoration: BoxDecoration(
            color: cs.primary,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: cs.primary.withOpacity(0.4), blurRadius: 8),
            ],
          ),
          padding: const EdgeInsets.all(8),
          child: Icon(Icons.camera_alt_outlined, size: 18, color: cs.onPrimary),
        ),
      ],
    );
  }
}
