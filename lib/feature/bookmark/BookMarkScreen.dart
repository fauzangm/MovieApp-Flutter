import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/core/language/language_store_instance.dart';
import 'package:movie_app/utils/ThemaHelper.dart';
import 'package:movie_app/feature/bookmark/vm/bookmark_vm.dart';
import 'package:movie_app/feature/bookmark/data/local/database/bookmark_database.dart';
import 'package:movie_app/feature/movie/data/remote/model/MovieResponse.dart';
import '../movie/components/movie_card.dart';

class BookMarkScreen extends StatefulWidget {
  const BookMarkScreen({Key? key}) : super(key: key);

  @override
  State<BookMarkScreen> createState() => _BookMarkScreenState();
}

class _BookMarkScreenState extends State<BookMarkScreen> {
  final BookmarkVM _bookmarkVM = bookmarkVM; // Use global instance

  @override
  void initState() {
    super.initState();
    _bookmarkVM.loadBookmarks();
  }

  String _getLocalizedText(String enText, String idText) {
    return languageStore.selectedLanguage == 'id' ? idText : enText;
  }

  @override
  void dispose() {
    // Don't dispose global bookmarkVM here
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

  Movie _bookmarkToMovie(Bookmark bookmark) {
    return Movie(
      adult: false,
      backdropPath: bookmark.backdropPath ?? '',
      genreIds: [],
      id: bookmark.id,
      originalLanguage: '',
      originalTitle: bookmark.title,
      overview: bookmark.overview,
      popularity: 0.0,
      posterPath: bookmark.posterPath ?? '',
      releaseDate: bookmark.releaseDate,
      title: bookmark.title,
      video: false,
      voteAverage: bookmark.voteAverage,
      voteCount: bookmark.voteCount,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.scaffoldBackground,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Header
            SliverAppBar(
              collapsedHeight: 70,
              expandedHeight: 70,
              backgroundColor: context.colors.scaffoldBackground,
              floating: false,
              pinned: true,
              leading: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: context.colors.surface,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: context.colors.textPrimary,
                  ),
                  onPressed: () => context.pop(),
                ),
              ),
              title: Text(
                _getLocalizedText('Bookmarks', 'Penanda'),
                style: TextStyle(
                  color: context.colors.textPrimary,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: false,
              elevation: 0,
            ),

            // Bookmarked Movies Grid
            Observer(
              builder: (_) {
                if (_bookmarkVM.isLoading) {
                  return const SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (_bookmarkVM.errorMessage != null) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        'Error: ${_bookmarkVM.errorMessage}',
                        style: TextStyle(color: context.colors.textPrimary),
                      ),
                    ),
                  );
                }

                return StreamBuilder<List<Bookmark>>(
                  stream: _bookmarkVM.bookmarkStream,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const SliverToBoxAdapter(
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }

                    final bookmarks = snapshot.data!;
                    if (bookmarks.isEmpty) {
                      return SliverToBoxAdapter(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(32),
                            child: Text(
                              'No bookmarks yet',
                              style: TextStyle(
                                color: context.colors.textSecondary,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      );
                    }

                    return SliverPadding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 16,
                      ),
                      sliver: SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 14,
                              mainAxisSpacing: 18,
                              childAspectRatio: 0.57,
                            ),
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final bookmark = bookmarks[index];
                          final movie = _bookmarkToMovie(bookmark);
                          return GestureDetector(
                            onTap: () {
                              context.pushNamed('detail', extra: movie);
                            },
                            child: MovieCard(
                              title: bookmark.title,
                              year: _year(bookmark.releaseDate),
                              rating: bookmark.voteAverage,
                              imageUrl: _posterUrl(bookmark.posterPath),
                              movieId: bookmark.id,
                              onBookmark: () =>
                                  _bookmarkVM.toggleBookmark(movie),
                            ),
                          );
                        }, childCount: bookmarks.length),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
