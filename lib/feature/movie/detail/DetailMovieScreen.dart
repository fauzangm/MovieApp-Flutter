import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/utils/ThemaHelper.dart';
import 'package:movie_app/feature/movie/data/remote/model/MovieResponse.dart';
import 'package:movie_app/feature/movie/vm/movie_vm.dart';
import 'components/cast_member_card.dart';
import 'components/similar_movies_section.dart';
import 'components/movie_poster_grid.dart';

class DetailMovieScreen extends StatefulWidget {
  const DetailMovieScreen({Key? key}) : super(key: key);

  @override
  State<DetailMovieScreen> createState() => _DetailMovieScreenState();
}

class _DetailMovieScreenState extends State<DetailMovieScreen> {
  late final MovieVM _vm;
  late final int _movieId;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _vm = MovieVM();
    _movieId = (GoRouterState.of(context).extra as Movie).id;
    _vm.fetchMovieDetail(_movieId);
    _vm.fetchSimilarMovies(_movieId);
    _vm.fetchMovieCast(_movieId);
  }

  @override
  void dispose() {
    _vm.dispose();
    super.dispose();
  }

  String _posterUrl(String? path) {
    if (path == null || path.isEmpty) return '';
    return 'https://image.tmdb.org/t/p/w500$path';
  }

  String _year(String date) {
    if (date.isEmpty) return '';
    if (date.length >= 4) return date.substring(0, 4);
    return date;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.scaffoldBackground,
      body: Observer(
        builder: (_) {
          final detail = _vm.movieDetail;

          if (detail == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return CustomScrollView(
            slivers: [
              // Custom AppBar with backdrop
              SliverAppBar(
                expandedHeight: 300,
                floating: false,
                pinned: true,
                backgroundColor: context.colors.scaffoldBackground,
                leading: Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: context.colors.textPrimary),
                    onPressed: () => context.pop(),
                  ),
                ),
                actions: [
                  Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: context.colors.bookmarkActive,
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
                      if (detail.backdropPath != null)
                        _posterUrl(detail.backdropPath)
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
                        detail.title,
                        style: TextStyle(
                          color: context.colors.textPrimary,
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
                                  detail.voteAverage.toStringAsFixed(1),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '(${detail.voteCount})',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          // Year
                          Text(
                            _year(detail.releaseDate),
                            style: TextStyle(
                              color: context.colors.textSecondary,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Genres
                      Wrap(
                        spacing: 8,
                        children: detail.genres
                            .map(
                                  (genre) => Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: context.colors.surface,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      genre.name,
                                      style: TextStyle(
                                        color: context.colors.textPrimary,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                )
                            .toList(),
                      ),
                      const SizedBox(height: 24),

                      // Overview Title
                      Text(
                        'Overview',
                        style: TextStyle(
                          color: context.colors.textPrimary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Overview Text
                      Text(
                        detail.overview,
                        style: TextStyle(
                          color: context.colors.textSecondary,
                          fontSize: 14,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 28),

                      // Cast List (Horizontal Scroll)
                      SizedBox(
                        height: 160,
                        child: Observer(
                          builder: (_) {
                            if (_vm.isLoadingCast) {
                              return const Center(child: CircularProgressIndicator());
                            }
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _vm.cast.length,
                              itemBuilder: (context, index) {
                                final castMember = _vm.cast[index];
                                return CastMemberCard(
                                  name: castMember.name,
                                  role: castMember.character,
                                  imageUrl: castMember.profilePath != null
                                      ? 'https://image.tmdb.org/t/p/w185${castMember.profilePath}'
                                      : 'https://picsum.photos/80/80?random=${castMember.id}',
                                  context: context,
                                );
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Similar Movies Section
                      Text(
                        'Similar Movies',
                        style: TextStyle(
                          color: context.colors.textPrimary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Observer(
                        builder: (_) {
                          if (_vm.isLoadingSimilar) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          return SimilarMoviesSection(
                            movies: _vm.similarMovies.map((m) => {
                              'title': m.title,
                              'year': _year(m.releaseDate),
                              'rating': m.voteAverage,
                              'image': _posterUrl(m.posterPath),
                            }).toList(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
