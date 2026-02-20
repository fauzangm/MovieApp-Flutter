import 'package:flutter/material.dart';
import 'package:movie_app/common/app_colors.dart';
import 'components/movie_card.dart';

class BerandaScreen extends StatelessWidget {
	const BerandaScreen({Key? key}) : super(key: key);

	final List<Map<String, dynamic>> sampleMovies = const [
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
			'title': 'Neon Nights',
			'year': '2024',
			'rating': 8.7,
			'image': 'https://picsum.photos/300/450?random=3'
		},
		{
			'title': 'Cinema Heart',
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
				child: Padding(
					padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
					child: Column(
						crossAxisAlignment: CrossAxisAlignment.start,
						children: [
							// Header
							Row(
								mainAxisAlignment: MainAxisAlignment.spaceBetween,
								children: [
									const Text(
										'Movie',
										style: TextStyle(
											color: AppColors.textPrimary,
											fontSize: 28,
											fontWeight: FontWeight.w800,
										),
									),
									Row(
										children: const [
											Icon(Icons.bookmark_border, color: Colors.white),
											SizedBox(width: 12),
											Icon(Icons.wb_sunny_outlined, color: Colors.white),
											SizedBox(width: 12),
											Icon(Icons.settings_outlined, color: Colors.white),
										],
									)
								],
							),
							const SizedBox(height: 12),

							// Search
							Container(
								padding: const EdgeInsets.symmetric(horizontal: 12),
								decoration: BoxDecoration(
									color: AppColors.surface,
									borderRadius: BorderRadius.circular(12),
								),
								child: const TextField(
									style: TextStyle(color: Colors.white),
									decoration: InputDecoration(
										icon: Icon(Icons.search, color: Colors.white54),
										hintText: 'Search movies...',
										hintStyle: TextStyle(color: Colors.white54),
										border: InputBorder.none,
									),
								),
							),
							const SizedBox(height: 12),

							// Tabs
							Row(
								children: [
									_buildTab('Popular', active: true),
									const SizedBox(width: 8),
									_buildTab('Top Rated'),
									const SizedBox(width: 8),
									_buildTab('Now Playing'),
								],
							),
							const SizedBox(height: 12),

							// Filter row
							Row(
								children: [
									Expanded(
										child: Container(
											padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
											decoration: BoxDecoration(
												color: AppColors.surface,
												borderRadius: BorderRadius.circular(12),
											),
											child: Row(
												mainAxisAlignment: MainAxisAlignment.spaceBetween,
												children: const [
													Text('Popularity', style: TextStyle(color: Colors.white70)),
													Icon(Icons.keyboard_arrow_down, color: Colors.white70),
												],
											),
										),
									),
									const SizedBox(width: 12),
									Container(
										padding: const EdgeInsets.all(12),
										decoration: BoxDecoration(
											color: AppColors.surface,
											borderRadius: BorderRadius.circular(12),
										),
										child: const Icon(Icons.tune, color: Colors.white),
									)
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
										return MovieCard(
											title: movie['title'],
											year: movie['year'],
											rating: movie['rating'],
											imageUrl: movie['image'],
											bookmarked: index % 2 == 0,
										);
									},
								),
							)
						],
					),
				),
			),
		);
	}

	Widget _buildTab(String label, {bool active = false}) {
		return Container(
			padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
			decoration: BoxDecoration(
				color: active ? AppColors.accent : AppColors.surface,
				borderRadius: BorderRadius.circular(24),
			),
			child: Text(
				label,
				style: TextStyle(
					color: active ? Colors.white : Colors.white70,
					fontWeight: FontWeight.w600,
				),
			),
		);
	}
}
