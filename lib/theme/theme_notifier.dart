import 'package:flutter/material.dart';

class ThemeNotifier with ChangeNotifier {
  ThemeData _themeData;
  bool isDarkMode = false;
  ThemeNotifier(this._themeData);

  getTheme() => _themeData;

  getIsDarkTheme() => isDarkMode;

  setTheme(ThemeData themeData, bool isDarkTheme) async {
    isDarkTheme = isDarkMode;
    _themeData = themeData;
    notifyListeners();
  }
}
