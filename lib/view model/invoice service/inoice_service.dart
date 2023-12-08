import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/model/invoice_model.dart';
import 'package:flutter_invoice_app/res/app_api/app_api_service.dart';
import 'package:flutter_invoice_app/utils/utils.dart';
import 'package:get/get.dart';

class InvoiceService extends GetxController{

  Rx<TextEditingController> businessName = TextEditingController().obs;
  Rx<TextEditingController> businessEmail = TextEditingController().obs;
  Rx<TextEditingController> businessNumber = TextEditingController().obs;
  Rx<TextEditingController> businessAddress = TextEditingController().obs;
  Rx<TextEditingController> payerName = TextEditingController().obs;
  Rx<TextEditingController> payerEmail = TextEditingController().obs;
  Rx<TextEditingController> payerNumber = TextEditingController().obs;
  Rx<TextEditingController> payerAddress = TextEditingController().obs;
  Rx<TextEditingController> itemName = TextEditingController().obs;
  Rx<TextEditingController> itemCost = TextEditingController().obs;
  Rx<TextEditingController> itemQuantity = TextEditingController().obs;
  Rx<TextEditingController> note = TextEditingController().obs;

  RxBool loading = false.obs;

  setLoading(bool value){
    loading.value = value;
  }

  static var date = DateTime.now();
  var formattedDate = "${date.day}-${date.month}-${date.year}";

  Invoice(BuildContext context)async{
    var a = int.parse(itemCost.value.text);
    var b = int.parse(itemQuantity.value.text);
    var total = a*b;

    setLoading(true);
    try{
      InvoiceModel invoiceModel = InvoiceModel(
        businessName: businessName.value.text,
        businessEmail: businessEmail.value.text,
        businessNumber: businessNumber.value.text,
        businessAddress: businessAddress.value.text,
        payerName: payerName.value.text,
        payerEmail: payerEmail.value.text,
        payerNumber: payerNumber.value.text,
        payerAddress: payerAddress.value.text,
        note: note.value.text,
        date: formattedDate,
      );
      await AppApiService.invoice.add(invoiceModel.toJson()).then((value)async{
       try{
         await AppApiService.invoice.doc(value.id).collection('items').add({
           "itemName" : itemName.value.text,
           "itemCost" : itemCost.value.text,
           "itemQuantity" : itemQuantity.value.text,
           "total" : total.toString(),
         });
       }catch(e){
         // Utils.flutterToast()
       }
        Get.back();
        Utils.flutterToast("Your Invoice is Created");
        setLoading(false);
        businessName.value.clear();
        businessEmail.value.clear();
        businessNumber.value.clear();
        businessAddress.value.clear();
        payerName.value.clear();
        payerEmail.value.clear();
        payerNumber.value.clear();
        payerAddress.value.clear();
        itemName.value.clear();
        itemCost.value.clear();
        itemQuantity.value.clear();
        note.value.clear();
      }).onError((error, stackTrace){
        setLoading(false);
        Utils.flutterToast(error.toString());
      });
    }catch(e){
      Utils.flutterToast(e.toString());
      setLoading(false);
    }
  }
}