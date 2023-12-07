import 'package:flutter/material.dart';
import '../colors/app_colors.dart';

class AppThemeData{
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColor.primaryColor,
      foregroundColor: AppColor.whiteColor,
    ),
    scaffoldBackgroundColor: Colors.grey.shade100,
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

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.black,
      foregroundColor: AppColor.whiteColor,
    ),
    scaffoldBackgroundColor: AppColor.blackColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColor.blackColor,
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
      backgroundColor: AppColor.blackColor,
    ),
    cardTheme: CardTheme(
      surfaceTintColor: AppColor.blackColor,
      color: AppColor.blackColor,
      elevation: 5,
    ),
    listTileTheme: ListTileThemeData(
      iconColor: AppColor.primaryColor,
      textColor: AppColor.whiteColor,
      selectedTileColor: AppColor.blackColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      prefixIconColor: AppColor.primaryColor,
      suffixIconColor: AppColor.primaryColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: AppColor.primaryColor,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: AppColor.primaryColor,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: AppColor.primaryColor,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: AppColor.errorColor,
        ),
      ),
    ),

  );

}