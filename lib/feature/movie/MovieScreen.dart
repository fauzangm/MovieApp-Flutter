import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/common/app_colors.dart';
import 'package:movie_app/utils/ThemaHelper.dart';
import 'components/movie_card.dart';

class MovieScreen extends StatelessWidget {
  const MovieScreen({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> sampleMovies = const [
    {
      'title': 'Stellar Odyssey',
      'year': '2024',
      'rating': 8.9,
      'image': 'https://picsum.photos/300/450?random=1',
    },
    {
      'title': 'Dragon Fire',
      'year': '2024',
      'rating': 8.5,
      'image': 'https://picsum.photos/300/450?random=2',
    },
    {
      'title': 'Neon Nights',
      'year': '2024',
      'rating': 8.7,
      'image': 'https://picsum.photos/300/450?random=3',
    },
    {
      'title': 'Cinema Heart',
      'year': '2024',
      'rating': 8.4,
      'image': 'https://picsum.photos/300/450?random=4',
    },
  ];

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
                        child: Icon(Icons.bookmark_border, color: context.colors.textPrimary)),
                      SizedBox(width: 12),
                      Icon(Icons.wb_sunny_outlined, color: context.colors.textPrimary),
                      SizedBox(width: 12),
                      GestureDetector(
                        onTap: () {
                          context.pushNamed('setting');
                        },
                        child: Icon(Icons.settings_outlined, color: context.colors.textPrimary)),
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
                child:  TextField(
                  style: TextStyle(color: context.colors.textPrimary),
                  decoration: InputDecoration(
                    icon: Icon(Icons.search, color: context.colors.textSecondary),
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
                  _buildTab('Popular',context, active: true),
                  const SizedBox(width: 8),
                  _buildTab('Top Rated',context),
                  const SizedBox(width: 8),
                  _buildTab('Now Playing',context),
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
                        children:  [
                          Text(
                            'Popularity',
                            style: TextStyle(color: context.colors.textSecondary),
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
                    child:  Icon(Icons.tune, color: context.colors.textPrimary),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Grid of movies
              Expanded(
                child: GridView.builder(
                  itemCount: sampleMovies.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 18,
                    childAspectRatio: 0.57,
                  ),
                  itemBuilder: (context, index) {
                    final movie = sampleMovies[index];
                    return GestureDetector(
                      onTap: () {
                        context.pushNamed(
                          'detail',
                          extra: movie, // kirim data movie
                        );
                      },
                      child: MovieCard(
                        title: movie['title'],
                        year: movie['year'],
                        rating: movie['rating'],
                        imageUrl: movie['image'],
                        bookmarked: index % 2 == 0,
                      ),
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

  Widget _buildTab(String label, BuildContext context, {bool active = false}) {
    return Container(
      padding:  EdgeInsets.symmetric(horizontal: 14, vertical: 8),
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
    );
  }
}
