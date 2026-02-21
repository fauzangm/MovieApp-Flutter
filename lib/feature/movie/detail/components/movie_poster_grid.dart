import 'package:flutter/material.dart';
import 'package:movie_app/common/app_colors.dart';
import 'package:movie_app/utils/ThemaHelper.dart';

class MoviePosterGrid extends StatelessWidget {
  final List<String> posterUrls;

  const MoviePosterGrid({
    Key? key,
    required this.posterUrls,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (posterUrls.isEmpty) {
      return Container(); // Return an empty container if there are no poster URLs
    }
    return Container(
      width: double.infinity,
      color: context.colors.surface,
      child: Image.network(
        posterUrls.first,
        fit: BoxFit.cover,
        width: double.infinity,
        height: 250, // Adjust height as needed
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: context.colors.cardBackground,
            child: Icon(
              Icons.image_not_supported,
              color: context.colors.textSecondary,
            ),
          );
        },
      ),
    );
  }
}
