import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/common/app_colors.dart';
import 'package:movie_app/core/theme/ThemaPrefence.dart';
import 'package:movie_app/core/theme/theme_store_instance.dart';
import 'package:movie_app/utils/ThemaHelper.dart';
import 'components/theme_setting_tile.dart';
import 'components/language_setting_tile.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  String selectedTheme = 'dark';
  String selectedLanguage = 'en';

  String _themeModeToString(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      default:
        return 'system';
    }
  }

  void _onLanguageChanged(String language) {
    setState(() {
      selectedLanguage = language;
    });
    // TODO: Implement language change logic
    print('Language changed to: $language');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.scaffoldBackground,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Header
            SliverAppBar(
              collapsedHeight: 70,
              expandedHeight: 70,
              backgroundColor: context.colors.scaffoldBackground,
              floating: false,
              pinned: true,
              leading: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: context.colors.surface,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: context.colors.textPrimary,
                  ),
                  onPressed: () => context.pop(),
                ),
              ),
              title: Text(
                'Settings',
                style: TextStyle(
                  color: context.colors.textPrimary,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: false,
              elevation: 0,
            ),

            // Content
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),

                    // Language Setting
                    LanguageSettingTile(
                      initialLanguage: selectedLanguage,
                      onLanguageChanged: _onLanguageChanged,
                    ),

                    const SizedBox(height: 12),

                    // Theme Setting
                   /// 🔥 THEME SECTION (Reactive)
                  Observer(
                    builder: (_) => ThemeSettingTile(
                      initialTheme:
                          _themeModeToString(themeStore.themeMode),
                      onThemeChanged: (value) {
                        themeStore.setTheme(value);
                      },
                    ),
                  ),

                    const SizedBox(height: 12),

                    // About Section
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 10,
                      ),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: context.colors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: context.colors.cardBackground,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: context.colors.cardBackground,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.info_outline,
                                  color: Color(0xFF00BCD4),
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 14),
                              Text(
                                'About',
                                style: TextStyle(
                                  color: context.colors.textPrimary,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Version
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Version',
                                style: TextStyle(
                                  color: context.colors.textSecondary,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                '1.0.0',
                                style: TextStyle(
                                  color: context.colors.textPrimary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          // Powered by
                          Text(
                            'Powered by The Movie Database API',
                            style: TextStyle(
                              color: context.colors.textSecondary,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    // App Logo and Name
                    Center(
                      child: Column(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xFF6B21A8), Color(0xFF1E3A8A)],
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              Icons.movie,
                              color: context.colors.textPrimary,
                              size: 50,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Movie',
                            style: TextStyle(
                              color: context.colors.textPrimary,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Discover Amazing Films',
                            style: TextStyle(
                              color: context.colors.textSecondary,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
