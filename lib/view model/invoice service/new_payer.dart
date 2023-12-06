import 'package:flutter/cupertino.dart';
import 'package:flutter_invoice_app/res/app_api/app_api_service.dart';
import 'package:flutter_invoice_app/utils/utils.dart';
import 'package:get/get.dart';

class NewPayerService extends GetxController{

  Rx<TextEditingController> payerName = TextEditingController().obs;
  Rx<TextEditingController> email = TextEditingController().obs;
  Rx<TextEditingController> phoneNumber = TextEditingController().obs;
  Rx<TextEditingController> address = TextEditingController().obs;

  RxBool loading = false.obs;

  setLoading(bool value){
    loading.value = value;
  }

  Payer(BuildContext context)async{
    setLoading(true);
    try{
      await AppApiService.payer.add({
        "payerName" : payerName.value.text,
        "email" : email.value.text,
        "phoneNumber" : phoneNumber.value.text,
        "address" : address.value.text,
      }).then((value){
        setLoading(false);
        Utils.flutterToast(value.toString());
        Get.back();
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