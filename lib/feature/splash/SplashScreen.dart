import 'dart:async';

import 'package:flutter/material.dart';
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
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.gradientStart, AppColors.gradientEnd],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Clapper board icon
            const Icon(
              Icons.movie_creation_outlined,
              size: 80,
              color: AppColors.textPrimary,
            ),
            const SizedBox(height: 40),

            // Movie title
            const Text(
              'Movie',
              style: TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),

            // Subtitle
            const Text(
              'Discover Amazing Films',
              style: TextStyle(
                fontSize: 18,
                color: AppColors.textSecondary,
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
            ? AppColors.indicatorActive
            : AppColors.indicatorInactive,
      ),
    );
  }
}
