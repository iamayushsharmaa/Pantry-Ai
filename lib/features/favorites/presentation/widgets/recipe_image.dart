import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';

class FavRecipeImage extends StatelessWidget {
  final String imageUrl;

  const FavRecipeImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
      child: Image.network(
        imageUrl,
        width: 110,
        height: 110,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          width: 110,
          height: 110,
          color: AppColors.grayLight,
          child: const Icon(Icons.image_not_supported),
        ),
      ),
    );
  }
}
