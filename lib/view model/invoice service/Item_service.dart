import 'package:flutter/cupertino.dart';
import 'package:flutter_invoice_app/model/item_model.dart';
import 'package:flutter_invoice_app/res/app_api/app_api_service.dart';
import 'package:get/get.dart';

class ItemService extends GetxController{

  Rx<TextEditingController> customerName = TextEditingController().obs;
  Rx<TextEditingController> customerEmail = TextEditingController().obs;
  Rx<TextEditingController> customerPhone = TextEditingController().obs;
  Rx<TextEditingController> customerAddress = TextEditingController().obs;
  Rx<TextEditingController> itemName = TextEditingController().obs;
  Rx<TextEditingController> itemCost = TextEditingController().obs;
  Rx<TextEditingController> discount = TextEditingController().obs;
  Rx<TextEditingController> tax = TextEditingController().obs;
  Rx<TextEditingController> description = TextEditingController().obs;


  RxBool loading = false.obs;

  setLoading(bool value){
    loading.value = value;
  }

  addItem(BuildContext context)async{
    ItemModel itemModel = ItemModel(
      customerName: customerName.value.text,
      customerEmail: customerEmail.value.text,
      customerPhone: customerPhone.value.text,
      customerAddress: customerAddress.value.text,
      itemName: itemName.value.text,
      itemCost: itemCost.value.text,
      discount: discount.value.text,
      tax: tax.value.text,
      description: description.value.text,
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
        customerName.value.clear();
        customerEmail.value.clear();
        customerPhone.value.clear();
        customerAddress.value.clear();
        itemName.value.clear();
        itemCost.value.clear();
        discount.value.clear();
        tax.value.clear();
        description.value.clear();
      }).onError((error, stackTrace){
        setLoading(false);
      });
    }catch(e){
      setLoading(false);

    }
  }
}