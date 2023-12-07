import 'package:flutter/cupertino.dart';
import 'package:flutter_invoice_app/res/app_api/app_api_service.dart';
import 'package:get/get.dart';

class PaymentService extends GetxController{
  Rx<TextEditingController> payment = TextEditingController().obs;

  RxBool loading = false.obs;

  setLoading(bool value){
    loading.value = value;
  }

  Payment(BuildContext context){
    setLoading(true);
    try{
      AppApiService.payment.add({
        "payment" : payment.value.text,
      }).then((value){
        setLoading(false);
        payment.value.clear();
      });
    }catch(e){
      setLoading(false);
      print(e);
    }
  }
}