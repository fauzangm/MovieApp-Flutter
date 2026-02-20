import 'package:flutter/material.dart';
import 'package:movie_app/feature/bookmark/BookMarkScreen.dart';
import 'package:movie_app/feature/movie/MovieScreen.dart';
import 'package:movie_app/feature/movie/detail/detail_movie_example.dart';
import 'package:movie_app/feature/setting/setting_example.dart';
import 'package:movie_app/feature/splash/SplashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BookMarkScreen(),
    );
  }
}