import 'package:flutter/material.dart';
import '../colors/app_colors.dart';

class AppThemeData{
  static ThemeData appTheme = ThemeData(
    useMaterial3: true,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColor.primaryColor,
      foregroundColor: AppColor.whiteColor,
    ),
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(
        color: AppColor.whiteColor,
      ),
      titleTextStyle: TextStyle(
        color: AppColor.whiteColor,
        fontSize: 25,
        fontWeight: FontWeight.w500,
      ),
      backgroundColor: AppColor.primaryColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      prefixIconColor: AppColor.primaryColor,
      suffixIconColor: AppColor.primaryColor,
    ),
  );
}