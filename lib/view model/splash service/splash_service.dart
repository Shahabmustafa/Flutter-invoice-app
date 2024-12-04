import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_invoice_app/res/routes/routes.dart';
import 'package:get/get.dart';

import '../../res/calculation/calculation.dart';

class SplashService{


  splashService(){
    if(FirebaseAuth.instance.currentUser != null){
      addDashboardIfNotExists();
      Timer(Duration(seconds: 5), (){
        Get.toNamed(AppRoutes.homeScreen);
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
        // If the document does not exist, create it
        await FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("dashboard")
            .doc(Calculation().date())
            .set({
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
    }catch(e){
      print("Error: $e");
    }
  }
}