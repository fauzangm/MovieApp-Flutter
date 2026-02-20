import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:movie_app/common/app_thema.dart';
import 'package:movie_app/core/router.dart';
import 'package:movie_app/core/theme/theme_store_instance.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: appRouter,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,

          // 🔥 INI YANG PENTING
          themeMode: themeStore.themeMode,
        );
      },
    );
  }
}