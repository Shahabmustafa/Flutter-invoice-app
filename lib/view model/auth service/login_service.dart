import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_invoice_app/res/app_api/app_api_service.dart';
import 'package:flutter_invoice_app/res/routes/routes.dart';
import 'package:flutter_invoice_app/utils/utils.dart';
import 'package:get/get.dart';

import '../../res/calculation/calculation.dart';
import '../notification_service/notification_service.dart';

class LoginService extends GetxController{
  RxBool loading = false.obs;
  Rx<TextEditingController> email = TextEditingController().obs;
  Rx<TextEditingController> password = TextEditingController().obs;
  // static final notification = NotificationService();


  RxBool visibility = true.obs;

  setLoading(bool value){
    loading.value = value;
  }

  isLogin(BuildContext context){
    setLoading(true);
    try{
      FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.value.text,
        password: password.value.text,
      ).then((value)async{
        setLoading(false);
        addDashboardIfNotExists(value.user!.uid);
        Utils.flutterToast("You have Successfully Login");
        email.value.clear();
        password.value.clear();
        Get.toNamed(AppRoutes.homeScreen);
      }).onError((error, stackTrace){
        setLoading(false);
        Utils.flutterToast("Please Check Your Email and Password");
      });
    }catch(e){
      Utils.flutterToast(e.toString());
      setLoading(false);
    }
  }

  static Calculation calculation = Calculation();


  Future<void> addDashboardIfNotExists(String userID) async {
    try {
      var dashboardDoc = await FirebaseFirestore.instance.collection("users").doc(userID).collection("dashboard").doc(Calculation().date()).get();

      if (!dashboardDoc.exists) {
        // If the document doesn't exist, create it with default values
        await FirebaseFirestore.instance.collection("users").doc(userID).collection("dashboard").doc(Calculation().date()).set({
          "date": calculation.date(),
          "cashSale": 0,
          "expense": 0,
          "creditSale": 0,
          "supplierPayment": 0,
          "totalInstallment": 0,
          "totalSale": 0,
        });
        print("Dashboard created for today's date: ${calculation.date()}");
      } else {
        // Document exists, no need to add
        print("Dashboard already exists for today's date.");
      }
    } catch (e) {
      print("Error while adding dashboard: $e");
    }
  }

}