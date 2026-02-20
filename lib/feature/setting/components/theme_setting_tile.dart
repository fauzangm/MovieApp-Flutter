import 'package:flutter/material.dart';
import 'package:movie_app/common/app_colors.dart';

class ThemeSettingTile extends StatefulWidget {
  final String initialTheme;
  final Function(String) onThemeChanged;

  const ThemeSettingTile({
    Key? key,
    required this.initialTheme,
    required this.onThemeChanged,
  }) : super(key: key);

  @override
  State<ThemeSettingTile> createState() => _ThemeSettingTileState();
}

class _ThemeSettingTileState extends State<ThemeSettingTile> {
  late String selectedTheme;

  @override
  void initState() {
    super.initState();
    selectedTheme = widget.initialTheme;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.cardBackground,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with icon
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.palette,
                  color: Color(0xFF9C27B0),
                  size: 24,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Theme',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Choose your app appearance',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Dropdown
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.surface,
                width: 1,
              ),
            ),
            child: DropdownButton<String>(
              value: selectedTheme,
              isExpanded: true,
              underline: const SizedBox.shrink(),
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.textSecondary,
              ),
              dropdownColor: AppColors.surface,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 16,
              ),
              items: const [
                DropdownMenuItem(
                  value: 'dark',
                  child: Text('Dark'),
                ),
                DropdownMenuItem(
                  value: 'light',
                  child: Text('Light'),
                ),
                DropdownMenuItem(
                  value: 'system',
                  child: Text('System'),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedTheme = value;
                  });
                  widget.onThemeChanged(value);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
