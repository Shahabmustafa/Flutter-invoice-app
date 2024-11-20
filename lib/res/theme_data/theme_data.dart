import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors/app_colors.dart';

class AppThemeData{
  static ThemeData lightTheme = ThemeData(
    /// scaffold background color theme
    scaffoldBackgroundColor: Colors.white,

    splashColor: AppColor.primaryColor,
    canvasColor: AppColor.whiteColor,
    useMaterial3: true,

    /// floating action button theme
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColor.primaryColor,
      foregroundColor: AppColor.whiteColor,
      shape: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),

    /// bottom navigation bar theme
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColor.primaryColor,
      selectedItemColor: AppColor.whiteColor,
      unselectedItemColor: AppColor.grayColor,
      selectedLabelStyle: GoogleFonts.lato(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColor.whiteColor
      ),
    ),

    /// appbar theme
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

    /// card theme
    cardTheme: CardTheme(
      surfaceTintColor: AppColor.whiteColor,
      color: AppColor.whiteColor,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      shadowColor: Colors.grey.withOpacity(0.5),
    ),

    /// listTile theme
    listTileTheme: ListTileThemeData(
      iconColor: AppColor.primaryColor,
      titleTextStyle: GoogleFonts.lato(
        fontWeight: FontWeight.w700,
        fontSize: 16,
        color: AppColor.primaryColor,
      ),
      leadingAndTrailingTextStyle:  GoogleFonts.lato(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: AppColor.blackColor,
      ),
    ),

    /// text field input decoration theme
    inputDecorationTheme: InputDecorationTheme(
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
      prefixIconColor: AppColor.primaryColor,
      suffixIconColor: AppColor.primaryColor,
      labelStyle: GoogleFonts.lato(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColor.blackColor,
      ),
    ),

    /// text theme
    textTheme: TextTheme(
      displayLarge: TextStyle(
        color: AppColor.blackColor,
      ),
    ),


    /// text button theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        // backgroundColor: AppColor.primaryColor,
        foregroundColor: AppColor.primaryColor,
      ),
    ),

    /// alert dialog theme
    dialogTheme: DialogTheme(
      backgroundColor: AppColor.whiteColor,
      alignment: Alignment.center,
      titleTextStyle: GoogleFonts.lato(
        fontSize: 24,
        color: AppColor.blackColor,
        fontWeight: FontWeight.w800,
      ),

      shape: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    ),

    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: AppColor.primaryColor,
    ),

    popupMenuTheme: PopupMenuThemeData(
      color: AppColor.whiteColor,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    splashColor: AppColor.blackColor,
    cardColor: AppColor.blackColor,
    useMaterial3: true,
    canvasColor: AppColor.primaryColor,

    /// floating action button theme
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColor.blackColor,
      foregroundColor: AppColor.primaryColor,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: AppColor.primaryColor,
          width: 3,
        ),
      )
    ),

    /// scaffold background color theme
    scaffoldBackgroundColor: AppColor.blackColor,
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColor.blackColor,
    ),

    /// bottom navigation bar theme
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColor.blackColor,
      selectedItemColor: AppColor.primaryColor,
      unselectedItemColor: AppColor.grayColor,
      selectedLabelStyle: GoogleFonts.lato(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColor.whiteColor
      ),
    ),

    /// appbar theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      iconTheme: IconThemeData(
        color: AppColor.primaryColor,
      ),
      titleTextStyle: TextStyle(
        color: AppColor.whiteColor,
        fontSize: 25,
        fontWeight: FontWeight.w500,
      ),
      backgroundColor: AppColor.blackColor,
    ),

    /// card heme
    cardTheme: CardTheme(
      surfaceTintColor: AppColor.blackColor,
      color: AppColor.blackColor,
      shape: UnderlineInputBorder(
        borderSide: BorderSide(
          color: AppColor.primaryColor,
        )
      ),
      elevation: 5,
    ),

    iconTheme: IconThemeData(
      color: AppColor.primaryColor,
    ),

    /// list tile theme
    listTileTheme: ListTileThemeData(
      iconColor: AppColor.primaryColor,
      textColor: AppColor.whiteColor,
      selectedTileColor: AppColor.blackColor,
    ),

    /// input decoration theme
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

    /// text theme
    textTheme: TextTheme(
      displayLarge: TextStyle(
        color: AppColor.whiteColor,
      ),
    ),

    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: AppColor.whiteColor,
    ),
  );

}