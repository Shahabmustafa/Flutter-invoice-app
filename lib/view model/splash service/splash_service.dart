import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_invoice_app/res/app_api/app_api_service.dart';
import 'package:flutter_invoice_app/res/calculation/calculation.dart';
import 'package:flutter_invoice_app/res/routes/routes.dart';
import 'package:flutter_invoice_app/view%20model/auth%20service/login_service.dart';
import 'package:get/get.dart';

class SplashService{

  LoginService loginService = LoginService();

  splashService(){
    if(FirebaseAuth.instance.currentUser != null){
      Timer(Duration(seconds: 5), () {
        Get.toNamed(AppRoutes.homeScreen);
        addDashboardIfNotExists();
      });
    }else{
      Timer(Duration(seconds: 5), () {
        Get.toNamed(AppRoutes.loginScreen);
      });
    }
  }

  Future<void> addDashboardIfNotExists() async {
    try {
      var dashboardDoc = await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("dashboard").doc(Calculation().date()).get();

      if (!dashboardDoc.exists) {
        // If the document doesn't exist, create it with default values
        await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("dashboard").doc(Calculation().date()).set({
          "date": Calculation().date(),
          "cashSale": 0,
          "expense": 0,
          "creditSale": 0,
          "supplierPayment": 0,
          "totalInstallment": 0,
          "totalSale": 0,
        });
        print("Dashboard created for today's date: ${Calculation().date()}");
      } else {
        // Document exists, no need to add
        print("Dashboard already exists for today's date.");
      }
    } catch (e) {
      print("Error while adding dashboard: $e");
    }
  }

}