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
      payment: "0",
      phoneNumber: companyPhoneNumber.value.text,
      supplierEmail: supplierEmail.value.text,
      supplierName: supplierName.value.text,
      supplierPhoneNumber: supplierPhoneNumber.value.text,
    );
    loading.setLoading(true);
    try{
      await AppApiService.supplier.add(supplierModel.toJson()).then((value){
        loading.setLoading(false);
        Get.back();
        companyName.value.clear();
        companyEmail.value.clear();
        companyAddress.value.clear();
        companyPhoneNumber.value.clear();
        supplierEmail.value.clear();
        supplierName.value.clear();
        supplierPhoneNumber.value.clear();
      }).onError((error, stackTrace){
        loading.setLoading(false);
      });
    }catch(e){
      loading.setLoading(false);
    }
  }

  editSupplier({required String supplierId})async{
    SupplierModel supplierModel = SupplierModel(
      companyName: companyName.value.text,
      companyEmail: companyEmail.value.text,
      address: companyAddress.value.text,
      payment: "0",
      phoneNumber: companyPhoneNumber.value.text,
      supplierEmail: supplierEmail.value.text,
      supplierName: supplierName.value.text,
      supplierPhoneNumber: supplierPhoneNumber.value.text,
    );
    loading.setLoading(true);
    try{
      await AppApiService.supplier.doc(supplierId).update(supplierModel.toJson()).then((value){
        Get.back();
        loading.setLoading(false);
        companyName.value.clear();
        companyEmail.value.clear();
        companyAddress.value.clear();
        companyPhoneNumber.value.clear();
        supplierEmail.value.clear();
        supplierName.value.clear();
        supplierPhoneNumber.value.clear();
      }).onError((error, stackTrace){
        print("Error : ${error}");
        loading.setLoading(false);
      });
    }catch(e){
      loading.setLoading(false);
      print("Error : ${e}");
    }
  }
}