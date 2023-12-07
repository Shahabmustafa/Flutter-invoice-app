import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static late SharedPreferences prefs;

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static const String _themeKey = "is_dark";

  static bool isDarkTheme() {
    return prefs.getBool(_themeKey) ?? false;
  }

  static Future<void> cacheTheme(bool isDark) async {
    await prefs.setBool(_themeKey, isDark);
  }
}