import 'package:flutter/cupertino.dart';
import 'package:flutter_invoice_app/model/item_model.dart';
import 'package:flutter_invoice_app/res/app_api/app_api_service.dart';
import 'package:get/get.dart';

class ItemService extends GetxController{

  Rx<TextEditingController> itemName = TextEditingController().obs;
  Rx<TextEditingController> itemQuantity = TextEditingController().obs;
  Rx<TextEditingController> itemCost = TextEditingController().obs;
  Rx<TextEditingController> WholePrice = TextEditingController().obs;

  RxBool loading = false.obs;

  setLoading(bool value){
    loading.value = value;
  }

  addItem(BuildContext context)async{
    ItemModel itemModel = ItemModel(
      itemName: itemName.value.text,
      itemQuantity: itemQuantity.value.text,
      itemCost: itemCost.value.text,
      WholePrice: WholePrice.value.text,
    );
    setLoading(true);
    try{
      await AppApiService.firestore
          .collection('users')
          .doc(AppApiService.userId)
          .collection("items")
          .add(itemModel.toJson()).then((value){
        setLoading(false);
        Get.back();
        itemName.value.clear();
        itemQuantity.value.clear();
        itemCost.value.clear();
        WholePrice.value.clear();
      }).onError((error, stackTrace){
        setLoading(false);
      });
    }catch(e){
      setLoading(false);

    }
  }
}