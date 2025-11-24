import 'package:flutter/material.dart';

class RecipeImage extends StatelessWidget {
  final String? imageUrl;
  final double height;

  const RecipeImage({
    super.key,
    required this.imageUrl,
    this.height = 250,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null) return const SizedBox.shrink();
    
    return Image.network(
      imageUrl!,
      height: height,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          height: height,
          color: Colors.red.shade100,
          child: const Icon(Icons.image_not_supported, size: 50),
        );
      },
    );
  }
}

