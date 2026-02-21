import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:movie_app/common/app_colors.dart';
import 'package:movie_app/utils/ThemaHelper.dart';
import 'package:movie_app/core/language/language_store_instance.dart';

class LanguageSettingTile extends StatefulWidget {
  final String initialLanguage;
  final Function(String) onLanguageChanged;

  const LanguageSettingTile({
    Key? key,
    required this.initialLanguage,
    required this.onLanguageChanged,
  }) : super(key: key);

  @override
  State<LanguageSettingTile> createState() => _LanguageSettingTileState();
}

class _LanguageSettingTileState extends State<LanguageSettingTile> {
  late String selectedLanguage;

  @override
  void initState() {
    super.initState();
    selectedLanguage = widget.initialLanguage;
  }

  String _getLocalizedText(String enText, String idText) {
    return languageStore.selectedLanguage == 'id' ? idText : enText;
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.colors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: context.colors.cardBackground, width: 1),
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
                    color: context.colors.cardBackground,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.language,
                    color: Color(0xFF2196F3),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getLocalizedText('Language', 'Bahasa'),
                        style: TextStyle(
                          color: context.colors.textPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        _getLocalizedText('Choose your preferred language', 'Pilih bahasa yang Anda inginkan'),
                        style: TextStyle(
                          color: context.colors.textSecondary,
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
                color: context.colors.cardBackground,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: context.colors.surface, width: 1),
              ),
              child: DropdownButton<String>(
                value: selectedLanguage,
                isExpanded: true,
                underline: const SizedBox.shrink(),
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: context.colors.textSecondary,
                ),
                dropdownColor: context.colors.surface,
                style: TextStyle(color: context.colors.textPrimary, fontSize: 16),
                items: const [
                  DropdownMenuItem(value: 'en', child: Text('English')),
                  DropdownMenuItem(value: 'id', child: Text('Bahasa Indonesia')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      selectedLanguage = value;
                    });
                    widget.onLanguageChanged(value);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
