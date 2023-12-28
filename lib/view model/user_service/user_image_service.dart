import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_invoice_app/res/app_api/app_api_service.dart';
import 'package:flutter_invoice_app/view%20model/auth%20service/login_service.dart';
import 'package:flutter_invoice_app/view%20model/image_picker/image_picker_service.dart';
import 'package:get/get.dart';

class UserProfileService extends GetxController{

  final ref = FirebaseStorage.instance.ref(AppApiService.userId);

  final pickImage = Get.put(ImagePickerService());

  final reload = Get.put(LoginService());


  Future<void> storeImage()async{
    reload.setLoading(true);
   try{
     final storageRef = ref.child("profileImage");
     final uploadTask = storageRef.putFile(File(pickImage.imagePath.value.toString()));
     await Future.value(uploadTask);
     final newUrl = await storageRef.getDownloadURL();
     reload.setLoading(false);
     FirebaseFirestore.instance
         .collection("users")
         .doc(AppApiService.userId)
         .update({
       "profileImage" : newUrl,
     }).then((value){
       reload.setLoading(false);
       Get.back();
     }).onError((error, stackTrace){
       reload.setLoading(false);
     });
   }catch(e){
     reload.setLoading(false);
   }
  }
}