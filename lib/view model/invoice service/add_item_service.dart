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
    setLoading(true);
    try{
      AppApiService.add_item.add({
        "itemName" : itemName.value.text,
        "itemCost" : itemCost.value.text,
        "quantity" : quantity.value.text,
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