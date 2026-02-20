import 'package:flutter/material.dart';
import 'package:movie_app/feature/beranda/BerandaScreen.dart';
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
      home: BerandaScreen(),
    );
  }
}