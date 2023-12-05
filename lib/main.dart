import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/colors/app_colors.dart';
import 'package:flutter_invoice_app/res/routes/routes.dart';
import 'package:flutter_invoice_app/view/splash/splash_screen.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
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
      ),
      home: SplashPage(),
      getPages: AppRoutes.appRoutes(),
    );
  }
}