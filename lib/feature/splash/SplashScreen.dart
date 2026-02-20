import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/utils/ThemaHelper.dart';
import '../../common/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int currentIndex = 0;
  late Timer timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        currentIndex = (currentIndex + 1) % 3;
      });
    });

    // Navigate after 3 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        timer.cancel(); // stop animation
        context.goNamed('movie'); // pindah ke movie
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [context.colors.gradientStart, context.colors.gradientEnd],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Clapper board icon
            Icon(
              Icons.movie_creation_outlined,
              size: 80,
              color: context.colors.textPrimary,
            ),
            const SizedBox(height: 40),

            // Movie title
            Text(
              'Movie',
              style: TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.bold,
                color: context.colors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),

            // Subtitle
            Text(
              'Discover Amazing Films',
              style: TextStyle(
                fontSize: 18,
                color: context.colors.textSecondary,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 120),

            // Page indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: _buildIndicator(isActive: index == currentIndex),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIndicator({required bool isActive}) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive
            ? context.colors.indicatorActive
            : context.colors.indicatorInactive,
      ),
    );
  }
}
