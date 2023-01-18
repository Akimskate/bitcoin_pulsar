import 'package:crypto_currencies/theme/theme_preferences.dart';
import 'package:flutter/material.dart';

class ThemeModel extends ChangeNotifier {
  bool _isDark = false;
  ThemePreferences _preferences = ThemePreferences ();
  bool get isDark => _isDark;

  ThemeModel() {
    _isDark = false;
    _preferences = ThemePreferences();
    getPreferences();
  }

  getPreferences() async {
    _isDark = await _preferences.getTheme();
    notifyListeners();
  }

  set isDark(bool value) {
    _isDark = value;
    _preferences.setTheme(value);
    notifyListeners();
  }
}