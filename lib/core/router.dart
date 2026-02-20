import 'package:go_router/go_router.dart';
import 'package:movie_app/feature/bookmark/BookMarkScreen.dart';
import 'package:movie_app/feature/movie/MovieScreen.dart';
import 'package:movie_app/feature/movie/detail/detail_movie_example.dart';
import 'package:movie_app/feature/setting/setting_example.dart';
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
      builder: (context, state) => const DetailMovieExample(),
    ),
    GoRoute(
      path: '/bookmark',
      name: 'bookmark',
      builder: (context, state) => const BookMarkScreen(),
    ),
    GoRoute(
      path: '/setting',
      name: 'setting',
      builder: (context, state) => const SettingScreenExample(),
    ),
  ],
);
