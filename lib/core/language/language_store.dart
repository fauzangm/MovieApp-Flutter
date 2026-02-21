import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'language_store.g.dart';

class LanguageStore = _LanguageStore with _$LanguageStore;

abstract class _LanguageStore with Store {
  static const String _languageKey = 'selected_language';
  
  @observable
  String selectedLanguage = 'en';

  _LanguageStore() {
    _loadLanguage();
  }

  @action
  Future<void> _loadLanguage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedLanguage = prefs.getString(_languageKey);
      print('LanguageStore: Loading language from SharedPreferences: $savedLanguage');
      selectedLanguage = savedLanguage ?? 'en';
      print('LanguageStore: Final selectedLanguage: $selectedLanguage');
    } catch (e) {
      print('LanguageStore: Error loading language: $e');
      selectedLanguage = 'en';
    }
  }

  @action
  Future<void> setLanguage(String language) async {
    try {
      print('LanguageStore: Setting language to: $language');
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_languageKey, language);
      selectedLanguage = language;
      print('LanguageStore: Language saved successfully');
      
      // Verify it was saved
      final verify = prefs.getString(_languageKey);
      print('LanguageStore: Verification - saved language: $verify');
    } catch (e) {
      print('LanguageStore: Error saving language: $e');
    }
  }

  String get languageParam => selectedLanguage == 'id' ? 'id-ID' : '';
}
