import 'package:flutter/material.dart';
import 'package:movie_app/common/app_colors.dart';

class MoviePosterGrid extends StatelessWidget {
  final List<String> posterUrls;

  const MoviePosterGrid({
    Key? key,
    required this.posterUrls,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.surface,
      child: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          childAspectRatio: 0.65,
        ),
        itemCount: posterUrls.length,
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(
              posterUrls[index],
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: AppColors.cardBackground,
                  child: const Icon(
                    Icons.image_not_supported,
                    color: AppColors.textSecondary,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
