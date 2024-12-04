import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_invoice_app/utils/utils.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController{

  final email = TextEditingController().obs;
  RxBool _loading = false.obs;

  RxBool get loading  => _loading;

  isLoading(bool value){
    value = _loading.value;
  }


  isForgetPassword()async{
    isLoading(true);
   try{
     await FirebaseAuth.instance.sendPasswordResetEmail(
       email: email.value.text.trim(),
     );
     Get.back();
     Utils.flutterToast("Send Link Your Email");
     email.value.clear();
     isLoading(false);
   }catch(e){
     isLoading(false);
   }
  }

}