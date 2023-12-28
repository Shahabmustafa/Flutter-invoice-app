import 'package:flutter/cupertino.dart';
import 'package:flutter_invoice_app/model/supplier_model.dart';
import 'package:flutter_invoice_app/res/app_api/app_api_service.dart';
import 'package:flutter_invoice_app/view%20model/loading_controller.dart';
import 'package:get/get.dart';

class SupplierController extends GetxController{

  final companyName = TextEditingController().obs;
  final companyEmail = TextEditingController().obs;
  final companyAddress = TextEditingController().obs;
  final companyPhoneNumber = TextEditingController().obs;
  final supplierEmail = TextEditingController().obs;
  final supplierName = TextEditingController().obs;
  final supplierPhoneNumber = TextEditingController().obs;
  final loading = Get.put(LoadingController());

  addSupplier()async{
    SupplierModel supplierModel = SupplierModel(
      companyName: companyName.value.text,
      companyEmail: companyEmail.value.text,
      address: companyAddress.value.text,
      phoneNumber: companyPhoneNumber.value.text,
      supplieremail: supplierEmail.value.text,
      supplierName: supplierName.value.text,
      supplierPhoneNumber: supplierPhoneNumber.value.text,
    );
    loading.setLoading(true);
    try{
      await AppApiService.supplier.add(supplierModel.toJson()).then((value){
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