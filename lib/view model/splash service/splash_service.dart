import 'dart:async';
import 'package:flutter_invoice_app/res/routes/routes.dart';
import 'package:get/get.dart';

class SplashService{
  splashService(){
    Timer(Duration(seconds: 5), () {
      Get.toNamed(AppRoutes.loginScreen);
    });
  }
}