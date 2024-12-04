import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_invoice_app/res/calculation/calculation.dart';
import 'package:flutter_invoice_app/utils/utils.dart';
import 'package:flutter_invoice_app/view%20model/user_service/user_service.dart';
import 'package:get/get.dart';

class SignUpService extends GetxController{

  Rx<TextEditingController> userName = TextEditingController().obs;
  Rx<TextEditingController> email = TextEditingController().obs;
  Rx<TextEditingController> password = TextEditingController().obs;
  Rx<TextEditingController> conPassword = TextEditingController().obs;
  RxBool loading = false.obs;
  RxBool Visibility = true.obs;
  RxBool confirmVisibility = true.obs;

  // static final notification = NotificationService();


  setLoading(bool value){
    loading.value = value;
  }

  isSignUp(BuildContext context){
    setLoading(true);
    try{
      FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.value.text,
        password: password.value.text,
      ).then((value)async{
        setLoading(false);
        UserService.userAddDataFirestore(
          userName.value.text,
          email.value.text,
          password.value.text,
        );
        await FirebaseFirestore.instance.collection("users").doc(value.user!.uid).collection("dashboard").doc(Calculation().date()).set({
          "date": Calculation().date(),
          "cashSale": 0,
          "expense": 0,
          "creditSale": 0,
          "supplierPayment": 0,
          "totalInstallment": 0,
          "totalSale": 0,
        });
        Utils.flutterToast("Your account has been create");
        userName.value.clear();
        email.value.clear();
        password.value.clear();
        conPassword.value.clear();
      }).onError((error, stackTrace){
        setLoading(false);
        Utils.flutterToast(error.toString());
      });
    }catch(e){
      setLoading(false);
      Utils.flutterToast(e.toString());
    }
  }
}