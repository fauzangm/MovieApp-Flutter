import 'package:flutter/material.dart';
import 'package:movie_app/common/app_colors.dart';
import 'package:movie_app/utils/ThemaHelper.dart';
import '../../components/rating_badge.dart';
import '../../components/bookmark_button.dart';

class MovieCard extends StatelessWidget {
  final String title;
  final String year;
  final double rating;
  final String imageUrl;
  final bool bookmarked;
  final VoidCallback? onBookmark;

  const MovieCard({
    Key? key,
    required this.title,
    required this.year,
    required this.rating,
    required this.imageUrl,
    this.bookmarked = false,
    this.onBookmark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Image
                Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),

                // Top-right bookmark
                Positioned(
                  top: 8,
                  right: 8,
                  child: BookmarkButton(
                    active: bookmarked,
                    onTap: onBookmark,
                  ),
                ),

                // Bottom-left rating
                Positioned(
                  left: 8,
                  bottom: 8,
                  child: RatingBadge(rating: rating),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          title,
          style:  TextStyle(
            color: context.colors.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          year,
          style:  TextStyle(
            color: context.colors.textSecondary,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
