import 'package:flutter/material.dart';
import '../colors/app_colors.dart';

class AppThemeData{
  static ThemeData appTheme = ThemeData(
    useMaterial3: true,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColor.primaryColor,
      foregroundColor: AppColor.whiteColor,
    ),
    scaffoldBackgroundColor: AppColor.whiteColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColor.whiteColor,
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
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
    cardTheme: CardTheme(
      surfaceTintColor: AppColor.whiteColor,
      color: AppColor.whiteColor,
      elevation: 5,
    ),
    listTileTheme: ListTileThemeData(
      iconColor: AppColor.primaryColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      prefixIconColor: AppColor.primaryColor,
      suffixIconColor: AppColor.primaryColor,
    ),
  );
}