import 'package:flutter/material.dart';
import 'package:movie_app/utils/ThemaHelper.dart';

class BookmarkButton extends StatelessWidget {
  final bool active;
  final VoidCallback? onTap;

  const BookmarkButton({Key? key, this.active = false, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: active ? context.colors.surface : Colors.black.withOpacity(0.45),
          shape: BoxShape.circle,
        ),
        child: Icon(
          active ? Icons.bookmark : Icons.bookmark_border,
          size: 18,
          color: active ? context.colors.bookmarkActive : Colors.white,
        ),
      ),
    );
  }
}
