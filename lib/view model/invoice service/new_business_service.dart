import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_invoice_app/res/app_api/app_api_service.dart';
import 'package:get/get.dart';

class NewBusinessService extends GetxController{

  Rx<TextEditingController> businessName = TextEditingController().obs;
  Rx<TextEditingController> email = TextEditingController().obs;
  Rx<TextEditingController> phoneNumber = TextEditingController().obs;
  Rx<TextEditingController> address = TextEditingController().obs;

  RxBool loading = false.obs;

  setLoading(bool value){
    loading.value = value;
  }

  newBusiness(BuildContext context){
    setLoading(true);
    try{
      AppApiService.business.add({
        "businessName" : businessName.value.text,
        "email" : email.value.text,
        "phoneNumber" : phoneNumber.value.text,
        "address" : address.value.text,
      }).then((value){
        setLoading(false);
        businessName.value.clear();
        email.value.clear();
        phoneNumber.value.clear();
        address.value.clear();
        Get.back();
      }).onError((error, stackTrace){
        setLoading(false);
      });
    }catch(e){
      setLoading(false);
    }
  }
}