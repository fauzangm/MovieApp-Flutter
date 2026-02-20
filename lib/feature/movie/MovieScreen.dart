import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/common/app_colors.dart';
import 'package:movie_app/core/theme/theme_store_instance.dart';
import 'package:movie_app/feature/movie/data/remote/model/MovieModel.dart';
import 'package:movie_app/feature/movie/vm/movie_vm.dart';
import 'package:movie_app/utils/ThemaHelper.dart';
import 'components/movie_card.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({Key? key}) : super(key: key);

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  static const String _tmdbPosterBaseUrl = 'https://image.tmdb.org/t/p/w500';

  final MovieVM _vm = MovieVM();
  final ScrollController _scrollController = ScrollController();

  String _selectedType = 'popular';

  @override
  void initState() {
    super.initState();
    _vm.fetchMovies(_selectedType);

    _scrollController.addListener(() {
      if (!_scrollController.hasClients) return;
      final position = _scrollController.position;
      if (position.pixels >= position.maxScrollExtent - 300) {
        _vm.fetchMovies(_selectedType, isLoadMore: true);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _vm.dispose();
    super.dispose();
  }

  void _onSelectType(String type) {
    if (_selectedType == type) return;
    setState(() {
      _selectedType = type;
    });
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(0);
    }
    _vm.fetchMovies(_selectedType);
  }

  String _posterUrl(Movie movie) {
    if (movie.posterPath.isEmpty) {
      return 'https://picsum.photos/300/450?random=${movie.id}';
    }
    return '$_tmdbPosterBaseUrl${movie.posterPath}';
  }

  String _year(Movie movie) {
    final date = movie.releaseDate;
    if (date.isEmpty) return '';
    if (date.length >= 4) return date.substring(0, 4);
    return date;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.scaffoldBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Movie',
                    style: TextStyle(
                      color: context.colors.textPrimary,
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.pushNamed('bookmark');
                        },
                        child: Icon(
                          Icons.bookmark_border,
                          color: context.colors.textPrimary,
                        ),
                      ),
                      SizedBox(width: 12),
                      Observer(
                        builder: (_) {
                          final isDark = themeStore.themeMode == ThemeMode.dark;
                          return GestureDetector(
                            onTap: themeStore.toggleTheme,
                            child: Icon(
                              isDark ? Icons.wb_sunny_outlined : Icons.nightlight_outlined,
                              color: context.colors.textPrimary,
                            ),
                          );
                        },
                      ),
                      SizedBox(width: 12),
                      GestureDetector(
                        onTap: () {
                          context.pushNamed('setting');
                        },
                        child: Icon(
                          Icons.settings_outlined,
                          color: context.colors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Search
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: context.colors.surface,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  style: TextStyle(color: context.colors.textPrimary),
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.search,
                      color: context.colors.textSecondary,
                    ),
                    hintText: 'Search movies...',
                    hintStyle: TextStyle(color: context.colors.textSecondary),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Tabs
              Row(
                children: [
                  _buildTab(
                    'Popular',
                    context,
                    active: _selectedType == 'popular',
                    onTap: () => _onSelectType('popular'),
                  ),
                  const SizedBox(width: 8),
                  _buildTab(
                    'Top Rated',
                    context,
                    active: _selectedType == 'top_rated',
                    onTap: () => _onSelectType('top_rated'),
                  ),
                  const SizedBox(width: 8),
                  _buildTab(
                    'Now Playing',
                    context,
                    active: _selectedType == 'now_playing',
                    onTap: () => _onSelectType('now_playing'),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Filter row
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: context.colors.surface,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Popularity',
                            style: TextStyle(
                              color: context.colors.textSecondary,
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: context.colors.textSecondary,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: context.colors.surface,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.tune, color: context.colors.textPrimary),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Grid of movies
              Expanded(
                child: Observer(
                  builder: (_) {
                    return StreamBuilder<List<Movie>>(
                      stream: _vm.movieStream,
                      builder: (context, snapshot) {
                        final movies = snapshot.data ?? const [];

                        if (_vm.errorMessage != null && movies.isEmpty) {
                          return Center(
                            child: Text(
                              _vm.errorMessage!,
                              style: TextStyle(color: context.colors.textPrimary),
                            ),
                          );
                        }

                        if (_vm.isLoading && movies.isEmpty) {
                          return const Center(child: CircularProgressIndicator());
                        }

                        return GridView.builder(
                          controller: _scrollController,
                          itemCount: movies.length + (_vm.isLoading ? 1 : 0),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 14,
                            mainAxisSpacing: 18,
                            childAspectRatio: 0.57,
                          ),
                          itemBuilder: (context, index) {
                            if (index >= movies.length) {
                              return const Center(child: CircularProgressIndicator());
                            }

                            final movie = movies[index];
                            return GestureDetector(
                              onTap: () {
                                context.pushNamed(
                                  'detail',
                                  extra: movie,
                                );
                              },
                              child: MovieCard(
                                title: movie.title,
                                year: _year(movie),
                                rating: movie.voteAverage,
                                imageUrl: _posterUrl(movie),
                                bookmarked: false,
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTab(
    String label,
    BuildContext context, {
    bool active = false,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: active ? context.colors.accent : context.colors.surface,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: active ? context.colors.surface : context.colors.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
