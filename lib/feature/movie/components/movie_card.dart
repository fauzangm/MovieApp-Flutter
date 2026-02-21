import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:movie_app/utils/ThemaHelper.dart';
import 'package:movie_app/feature/bookmark/vm/bookmark_vm.dart';
import '../../components/rating_badge.dart';
import '../../components/bookmark_button.dart';

class MovieCard extends StatefulWidget {
  final String title;
  final String year;
  final double rating;
  final String imageUrl;
  final int movieId;
  final VoidCallback? onBookmark;

  const MovieCard({
    Key? key,
    required this.title,
    required this.year,
    required this.rating,
    required this.imageUrl,
    required this.movieId,
    this.onBookmark,
  }) : super(key: key);

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Image
                  Image.network(widget.imageUrl, fit: BoxFit.cover),
                  // Top-right bookmark
                  if (widget.onBookmark != null)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: BookmarkButton(
                        active: bookmarkVM.bookmarkedIds.contains(
                          widget.movieId,
                        ),
                        onTap: widget.onBookmark,
                      ),
                    ),

                  // Bottom-left rating
                  Positioned(
                    left: 8,
                    bottom: 8,
                    child: RatingBadge(rating: widget.rating),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            widget.title,
            style: TextStyle(
              color: context.colors.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            widget.year,
            style: TextStyle(color: context.colors.textSecondary, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
