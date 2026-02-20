import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/common/app_colors.dart';
import '../movie/components/movie_card.dart';

class BookMarkScreen extends StatefulWidget {
  const BookMarkScreen({Key? key}) : super(key: key);

  @override
  State<BookMarkScreen> createState() => _BookMarkScreenState();
}

class _BookMarkScreenState extends State<BookMarkScreen> {
  // Sample bookmarked movies
  final List<Map<String, dynamic>> bookmarkedMovies = const [
    {
      'title': 'Stellar Odyssey',
      'year': '2024',
      'rating': 8.9,
      'image': 'https://picsum.photos/300/450?random=1'
    },
    {
      'title': 'Dragon Fire',
      'year': '2024',
      'rating': 8.5,
      'image': 'https://picsum.photos/300/450?random=2'
    },
    {
      'title': 'Quantum Paradox',
      'year': '2024',
      'rating': 8.7,
      'image': 'https://picsum.photos/300/450?random=3'
    },
    {
      'title': 'The Last Stand',
      'year': '2024',
      'rating': 8.4,
      'image': 'https://picsum.photos/300/450?random=4'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Header
            SliverAppBar(
              collapsedHeight: 70,
              expandedHeight: 70,
              backgroundColor: AppColors.scaffoldBackground,
              floating: false,
              pinned: true,
              leading: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: AppColors.textPrimary,
                  ),
                  onPressed: () => context.pop(),
                ),
              ),
              title: const Text(
                'Bookmarks',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: false,
              elevation: 0,
            ),

            // Bookmarked Movies Grid
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 18,
                  childAspectRatio: 0.57,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final movie = bookmarkedMovies[index];
                    return MovieCard(
                      title: movie['title'],
                      year: movie['year'],
                      rating: movie['rating'],
                      imageUrl: movie['image'],
                      bookmarked: true,
                      onBookmark: () {
                        // Handle bookmark removal
                        _removeFromBookmark(index);
                      },
                    );
                  },
                  childCount: bookmarkedMovies.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _removeFromBookmark(int index) {
    // TODO: Implement bookmark removal logic
    print('Removed bookmark at index $index');
  }
}
