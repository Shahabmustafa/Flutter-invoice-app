// ignore_for_file: no_leading_underscores_for_local_identifiers
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../shared_pref.dart';

class ThemeController extends GetxController {
  bool isDark = false;

  @override
  void onInit() async {
    super.onInit();
    isDark = SharedPrefHelper.isDarkTheme();
    Get.changeThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
  }

  void changeTheme(bool _isDark) async {
    isDark = _isDark;
    await SharedPrefHelper.cacheTheme(_isDark);
    Get.changeThemeMode(_isDark ? ThemeMode.dark : ThemeMode.light);
    update();
  }
}