import 'package:flutter/cupertino.dart';
import 'package:flutter_invoice_app/model/customer_model.dart';
import 'package:flutter_invoice_app/res/app_api/app_api_service.dart';
import 'package:flutter_invoice_app/view%20model/loading_controller.dart';
import 'package:get/get.dart';

class CustomerController extends GetxController{

  final customerName = TextEditingController().obs;
  final customerEmail = TextEditingController().obs;
  final customerPhone = TextEditingController().obs;
  final customerAddress = TextEditingController().obs;
  final customerPayment = TextEditingController().obs;
  final customerCNIC = TextEditingController().obs;
  final customerCategory = TextEditingController().obs;

  final loading = Get.put(LoadingController());

  addCustomerData()async{
    CustomerModel customerModel = CustomerModel(
      customerName: customerName.value.text,
      email: customerEmail.value.text,
      phoneNumber: customerPhone.value.text,
      address: customerAddress.value.text,
      payment: customerPayment.value.text,
      cnic: customerCNIC.value.text,
      category: customerCategory.value.text,
    );
    loading.setLoading(true);
    try{
      await AppApiService.customer.add(customerModel.toJson()).then((value){
        loading.setLoading(false);
        Get.back();
      }).onError((error, stackTrace){
        loading.setLoading(false);
      });
    }catch(e){
      loading.setLoading(false);
    }
  }
}