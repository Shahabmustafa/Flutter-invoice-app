import 'dart:async';

import 'package:flutter_invoice_app/res/app_api/app_api_service.dart';
import 'package:flutter_invoice_app/res/routes/routes.dart';
import 'package:get/get.dart';

class SplashService{

  splashService(){
    if(AppApiService.user != null){
      Timer(Duration(seconds: 5), () {
        Get.toNamed(AppRoutes.homeScreen);
      });
    }else{
      Timer(Duration(seconds: 5), () {
        Get.toNamed(AppRoutes.loginScreen);
      });
    }
  }
}