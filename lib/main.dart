import 'package:flutter/material.dart';
import 'package:movie_app/common/app_thema.dart';
import 'package:movie_app/core/router.dart';


void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,

      // 🔥 Tambahkan ini
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system, // ikut system
    );
  }
}