import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors/app_colors.dart';

class AppThemeData{
  static ThemeData lightTheme = ThemeData(
    splashColor: AppColor.primaryColor,
    canvasColor: AppColor.whiteColor,
    useMaterial3: true,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColor.primaryColor,
      foregroundColor: AppColor.whiteColor,
    ),
    scaffoldBackgroundColor: Colors.white,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColor.whiteColor,
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      iconTheme: IconThemeData(
        color: AppColor.whiteColor,
      ),
      titleTextStyle: GoogleFonts.lora(
        color: AppColor.whiteColor,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      backgroundColor: AppColor.primaryColor,
    ),
    cardTheme: CardTheme(
      surfaceTintColor: AppColor.whiteColor,
      color: AppColor.whiteColor,
      elevation: 1,
    ),
    listTileTheme: ListTileThemeData(
      iconColor: AppColor.primaryColor,
      titleTextStyle: GoogleFonts.lato(
        fontWeight: FontWeight.w500,
        fontSize: 16,
        color: AppColor.blackColor,
      ),
      leadingAndTrailingTextStyle:  GoogleFonts.lato(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: AppColor.blackColor,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      prefixIconColor: AppColor.primaryColor,
      suffixIconColor: AppColor.primaryColor,
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        color: AppColor.blackColor,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    splashColor: AppColor.blackColor,
    cardColor: AppColor.blackColor,
    useMaterial3: true,
    canvasColor: AppColor.primaryColor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColor.blackColor,
      foregroundColor: AppColor.whiteColor,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: AppColor.primaryColor,
          width: 3,
        ),
      )
    ),
    scaffoldBackgroundColor: AppColor.blackColor,
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColor.blackColor,
    ),
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
    textTheme: TextTheme(
      displayLarge: TextStyle(
        color: AppColor.whiteColor,
      ),
    ),
  );

}