import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_invoice_app/res/app_api/app_api_service.dart';
import 'package:get/get.dart';

class AddItemService extends GetxController{

  Rx<TextEditingController> itemName = TextEditingController().obs;
  Rx<TextEditingController> itemCost = TextEditingController().obs;
  Rx<TextEditingController> quantity = TextEditingController().obs;
  RxBool loading = false.obs;
  setLoading(bool value){
    loading.value = value;
  }


  addItem(BuildContext context){
    var a = int.parse(itemCost.value.text);
    var b = int.parse(quantity.value.text);
    var date = DateTime.now();
    var formattedDate = "${date.day}-${date.month}-${date.year}";
    setLoading(true);
    try{
      AppApiService.addItem.add({
        "itemName" : itemName.value.text,
        "itemCost" : itemCost.value.text,
        "quantity" : quantity.value.text,
        "total" : a*b,

      }).then((value){
        setLoading(false);
        itemName.value.clear();
        itemCost.value.clear();
        quantity.value.clear();
        Get.back();
      }).onError((error, stackTrace){
        setLoading(false);
      });
    }catch(e){
      setLoading(false);
    }
  }
}