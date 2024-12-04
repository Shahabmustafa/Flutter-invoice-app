import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_invoice_app/utils/utils.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController{

  final updatePasswordController = TextEditingController().obs;
  final confirmPasswordController = TextEditingController().obs;
  final oldPasswordController = TextEditingController().obs;

  RxBool newPassword = true.obs;
  RxBool oldPassword = true.obs;
  RxBool confirmPassword = true.obs;
  RxBool _loading = false.obs;

  RxBool get loading => _loading;

  isLoading(bool value){
    value = _loading.value;
  }

  isChangePassword()async{
    isLoading(true);
   try{
     var user = await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();
     var password = user.data()?["password"];
     if(updatePasswordController.value.text.isNotEmpty && confirmPasswordController.value.text.isNotEmpty && oldPasswordController.value.text.isNotEmpty)
       if(password == oldPasswordController.value.text){
         if(updatePasswordController.value.text != confirmPasswordController.value.text){
           Utils.flutterToast("Not Match Confirm Password");
           isLoading(false);
         }else{
           await FirebaseAuth.instance.currentUser?.updatePassword(updatePasswordController.value.text).then((value){
             Utils.flutterToast("Your Password Successfully Changed");
             FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update({
               "password" : confirmPasswordController.value.text.trim(),
             });
             Get.back();
             isLoading(false);
           });
         }
       }else{
         Utils.flutterToast("Old Password is Incorrect");
       }else{
       Utils.flutterToast("Fill the Field");
     }
   }catch(e){
     isLoading(false);
   }
  }

}