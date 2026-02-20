import 'package:go_router/go_router.dart';
import 'package:movie_app/feature/bookmark/BookMarkScreen.dart';
import 'package:movie_app/feature/movie/MovieScreen.dart';
import 'package:movie_app/feature/movie/detail/DetailMovieScreen.dart';
import 'package:movie_app/feature/setting/SettingScreen.dart';
import 'package:movie_app/feature/splash/SplashScreen.dart';


final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/movie',
      name: 'movie',
      builder: (context, state) => const MovieScreen(),
    ),
    GoRoute(
      path: '/detail',
      name: 'detail',
      builder: (context, state) => DetailMovieScreen(
      movieTitle: 'Stellar Odyssey',
      year: '2024',
      rating: 8.9,
      ratingCount: 5234,
      genres: const ['Science Fiction', 'Adventure'],
      overview:
          'A group of explorers venture into the unknown reaches of space to find a new home for humanity. With cutting-edge technology and unwavering determination, they face the mysteries of the cosmos while battling unexpected threats.',
      cast: const [
        {
          'name': 'John Anderson',
          'role': 'Lead Role',
          'imageUrl': 'https://picsum.photos/80/80?random=20',
        },
        {
          'name': 'Sarah Mitchell',
          'role': 'Supporting Role',
          'imageUrl': 'https://picsum.photos/80/80?random=21',
        },
        {
          'name': 'Michael Chen',
          'role': 'Antagonist',
          'imageUrl': 'https://picsum.photos/80/80?random=22',
        },
        {
          'name': 'Emma Davis',
          'role': 'Supporting Role',
          'imageUrl': 'https://picsum.photos/80/80?random=23',
        },
      ],
      similarMovies: const [
        {
          'title': 'Quantum Paradox',
          'year': '2024',
          'rating': 8.7,
          'image': 'https://picsum.photos/140/200?random=1'
        },
        {
          'title': 'Shadow Warriors',
          'year': '2024',
          'rating': 7.9,
          'image': 'https://picsum.photos/140/200?random=2'
        },
        {
          'title': 'Heartstrings',
          'year': '2024',
          'rating': 8.2,
          'image': 'https://picsum.photos/140/200?random=3'
        },
        {
          'title': 'Dragon Fire',
          'year': '2024',
          'rating': 8.5,
          'image': 'https://picsum.photos/140/200?random=4'
        },
      ],
    )
  ,
    ),
    GoRoute(
      path: '/bookmark',
      name: 'bookmark',
      builder: (context, state) => const BookMarkScreen(),
    ),
    GoRoute(
      path: '/setting',
      name: 'setting',
      builder: (context, state) => const SettingScreen(),
    ),
  ],
);
