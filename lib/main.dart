import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/localization/localization.dart';
import 'package:flutter_invoice_app/res/routes/routes.dart';
import 'package:flutter_invoice_app/res/theme_data/theme_data.dart';
import 'package:flutter_invoice_app/view%20model/binding.dart';
import 'package:flutter_invoice_app/view%20model/shared_pref.dart';
import 'package:flutter_invoice_app/view%20model/swith_service/swith_service.dart';
import 'package:flutter_invoice_app/view/splash/splash_screen.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ThemeController(),
      builder: (controller) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Invoice App',
        initialBinding: Binding(),
        theme: AppThemeData.lightTheme,
        darkTheme: AppThemeData.darkTheme,
        themeMode: controller.isDark ? ThemeMode.dark : ThemeMode.light,
        translations: Languages(),
        locale: const Locale('en','us'),
        fallbackLocale: Locale('en','us'),
        home: SplashPage(),
        getPages: AppRoutes.appRoutes(),
      ),
    );
  }
}