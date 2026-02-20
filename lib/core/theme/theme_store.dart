import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'theme_store.g.dart';

class ThemeStore = _ThemeStore with _$ThemeStore;

abstract class _ThemeStore with Store {
  static const _key = 'app_theme';

  _ThemeStore() {
    loadTheme();
  }

  @observable
  ThemeMode themeMode = ThemeMode.system;

  @action
  Future<void> setTheme(String value) async {
    if (value == 'light') {
      themeMode = ThemeMode.light;
    } else if (value == 'dark') {
      themeMode = ThemeMode.dark;
    } else {
      themeMode = ThemeMode.system;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, value);
  }

  @action
  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_key) ?? 'system';

    if (saved == 'light') {
      themeMode = ThemeMode.light;
    } else if (saved == 'dark') {
      themeMode = ThemeMode.dark;
    } else {
      themeMode = ThemeMode.system;
    }
  }
}