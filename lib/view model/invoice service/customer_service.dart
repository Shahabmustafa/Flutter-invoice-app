import 'package:flutter/cupertino.dart';
import 'package:flutter_invoice_app/model/customer_model.dart';
import 'package:flutter_invoice_app/res/app_api/app_api_service.dart';
import 'package:get/get.dart';

class CustomerService extends GetxController{

  Rx<TextEditingController> customerName = TextEditingController().obs;
  Rx<TextEditingController> customerEmail = TextEditingController().obs;
  Rx<TextEditingController> customerPhone = TextEditingController().obs;
  Rx<TextEditingController> customerAddress = TextEditingController().obs;

  RxBool loading = false.obs;

  setLoading(bool value){
    loading.value = value;
  }

  customerService(BuildContext context){
    CustomerModel customerModel = CustomerModel(
      CustomerName: customerName.value.text,
      CustomerEmail: customerEmail.value.text,
      CustomerPhone: customerPhone.value.text,
      CustomerAddress: customerPhone.value.text,
    );
    setLoading(true);
    try{
      AppApiService.firestore
          .collection("users")
          .doc(AppApiService.userId)
          .collection("customer")
          .add(customerModel.toJson()).then((value){
        setLoading(false);
      }).onError((error, stackTrace){
        setLoading(false);
      });
    }catch(e){
      setLoading(false);

    }
  }
}