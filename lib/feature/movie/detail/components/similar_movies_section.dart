import 'package:flutter/material.dart';
import 'package:movie_app/common/app_colors.dart';
import '../../components/movie_card.dart';

class SimilarMoviesSection extends StatelessWidget {
  final List<Map<String, dynamic>> movies;

  const SimilarMoviesSection({
    Key? key,
    required this.movies,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: SizedBox(
              width: 140,
              child: MovieCard(
                title: movie['title'],
                year: movie['year'],
                rating: movie['rating'],
                imageUrl: movie['image'],
                bookmarked: false,
              ),
            ),
          );
        },
      ),
    );
  }
}
