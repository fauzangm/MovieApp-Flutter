import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/common/app_colors.dart';
import 'components/cast_member_card.dart';
import 'components/similar_movies_section.dart';
import 'components/movie_poster_grid.dart';

class DetailMovieScreen extends StatelessWidget {
  final String movieTitle;
  final String year;
  final double rating;
  final int ratingCount;
  final List<String> genres;
  final String overview;
  final List<Map<String, dynamic>> cast;
  final List<Map<String, dynamic>> similarMovies;

  const DetailMovieScreen({
    Key? key,
    required this.movieTitle,
    required this.year,
    required this.rating,
    required this.ratingCount,
    required this.genres,
    required this.overview,
    required this.cast,
    required this.similarMovies,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: CustomScrollView(
        slivers: [
          // Custom AppBar with backdrop
          SliverAppBar(
            expandedHeight: 300,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.scaffoldBackground,
            leading: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => context.pop(),
              ),
            ),
            actions: [
              Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.bookmarkActive,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  icon: const Icon(Icons.bookmark, color: Colors.black),
                  onPressed: () {},
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: MoviePosterGrid(
                posterUrls: [
                  'https://picsum.photos/150/250?random=10',
                  'https://picsum.photos/150/250?random=11',
                  'https://picsum.photos/150/250?random=12',
                  'https://picsum.photos/150/250?random=13',
                  'https://picsum.photos/150/250?random=14',
                  'https://picsum.photos/150/250?random=15',
                  'https://picsum.photos/150/250?random=16',
                  'https://picsum.photos/150/250?random=17',
                  'https://picsum.photos/150/250?random=18',
                ],
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Movie Title
                  Text(
                    movieTitle,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Rating and Info Row
                  Row(
                    children: [
                      // Rating Badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 18,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              rating.toStringAsFixed(1),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '($ratingCount)',
                              style: const TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Year
                      Text(
                        year,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Genres
                  Wrap(
                    spacing: 8,
                    children: genres
                        .map(
                          (genre) => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              genre,
                              style: const TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 24),

                  // Overview Title
                  const Text(
                    'Overview',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Overview Text
                  Text(
                    overview,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Cast Title
                  const Text(
                    'Cast',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Cast List (Horizontal Scroll)
                  SizedBox(
                    height: 160,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: cast.length,
                      itemBuilder: (context, index) {
                        final castMember = cast[index];
                        return CastMemberCard(
                          name: castMember['name'],
                          role: castMember['role'],
                          imageUrl: castMember['imageUrl'],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Similar Movies Section
                  const Text(
                    'Similar Movies',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SimilarMoviesSection(
                    movies: similarMovies,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
