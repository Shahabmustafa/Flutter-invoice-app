import 'package:flutter/cupertino.dart';
import 'package:flutter_invoice_app/model/item_model.dart';
import 'package:flutter_invoice_app/res/app_api/app_api_service.dart';
import 'package:flutter_invoice_app/view%20model/notification_service/notification_service.dart';
import 'package:get/get.dart';
import 'package:workmanager/workmanager.dart';

class UpdateItemService extends GetxController{

  Rx<TextEditingController> customerName = TextEditingController().obs;
  Rx<TextEditingController> customerEmail = TextEditingController().obs;
  Rx<TextEditingController> customerPhone = TextEditingController().obs;
  Rx<TextEditingController> customerAddress = TextEditingController().obs;
  Rx<TextEditingController> itemName = TextEditingController().obs;
  Rx<TextEditingController> itemCost = TextEditingController().obs;
  Rx<TextEditingController> discount = TextEditingController().obs;
  Rx<TextEditingController> tax = TextEditingController().obs;
  Rx<TextEditingController> paid = TextEditingController().obs;
  Rx<TextEditingController> totalPrice = TextEditingController().obs;
  Rx<TextEditingController> startDate = TextEditingController().obs;
  Rx<TextEditingController> dueDate = TextEditingController().obs;


  RxBool loading = false.obs;

  setLoading(bool value){
    loading.value = value;
  }

  updateItem(BuildContext context,String update)async{
    var data = int.parse(discount.value.text) / 100 * int.parse(itemCost.value.text);
    // var discountPrice = int.parse(itemCost.value.text) - data;

    var taxs = int.parse(tax.value.text) / 100 * int.parse(itemCost.value.text);
    // var taxPrice = int.parse(itemCost.value.text) + taxs;

    var addtex = int.parse(itemCost.value.text) + taxs;

    var addDiscount = addtex - data;

    var totalPaid = addDiscount - int.parse(paid.value.text);

    // var taxPrice = int.parse()
    ItemModel itemModel = ItemModel(
      customerName: customerName.value.text,
      customerEmail: customerEmail.value.text,
      customerPhone: customerPhone.value.text,
      customerAddress: customerAddress.value.text,
      itemName: itemName.value.text,
      itemCost: itemCost.value.text,
      discount: discount.value.text,
      tax: tax.value.text,
      paid: paid.value.text,
      total: addDiscount.toString(),
      totalDept: totalPaid.toString(),
      dateNow: startDate.value.text,
      duaDate: dueDate.value.text,
    );
    setLoading(true);
    try{
      await AppApiService.firestore
          .collection('users')
          .doc(AppApiService.userId)
          .collection("items")
          .doc(update)
          .update(itemModel.toJson()).then((value){
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
        paid.value.clear();
        NotificationService().simpleNotificationShow("Your Invoice is Update");
      }).onError((error, stackTrace){
        setLoading(false);
      });
    }catch(e){
      setLoading(false);

    }
  }
}