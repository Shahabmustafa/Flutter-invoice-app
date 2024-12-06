import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/model/item_model.dart';
import 'package:flutter_invoice_app/utils/utils.dart';
import 'package:flutter_invoice_app/view%20model/loading_controller.dart';
import 'package:get/get.dart';

class ItemController extends GetxController{

  final Rx<List<ItemModel>> _itemList = Rx<List<ItemModel>>([]);
  List<ItemModel> get itemList => _itemList.value;


  RxList<String> dropdownCategory = <String>[].obs;
  RxList<String> dropdownCompany = <String>[].obs;
  RxString selectCompany = "".obs;
  RxString selectCategory = "".obs;


  final barcode = TextEditingController().obs;
  final itemName = TextEditingController().obs;
  final sale = TextEditingController().obs;
  final cost = TextEditingController().obs;
  final discount = TextEditingController().obs;
  final stock = TextEditingController().obs;
  final categori = TextEditingController().obs;
  final tax = TextEditingController().obs;

  final loading = Get.put(LoadingController());



  // items add data in Firebase Data base
  addItemData()async{
    loading.setLoading(true);
    try{
      var itemId = await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("items").doc();
      ItemModel itemModel = ItemModel(
        barcode: barcode.value.text,
        itemId: itemId.id,
        itemName: itemName.value.text,
        salePrice: int.parse(sale.value.text),
        purchasePrice: int.parse(cost.value.text),
        discount: int.parse(discount.value.text),
        stock: 0,
        category: selectCategory.value,
        tax: int.parse(tax.value.text),
        companyName: selectCompany.value,
      );
      await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("items").doc(itemId.id).set(itemModel.toJson()).then((value){
        loading.setLoading(false);
        Get.back();
      }).onError((error, stackTrace){
        loading.setLoading(false);
      });
    }catch(e){
      loading.setLoading(false);
    }
  }

  editItem(String ItemId)async{
    loading.setLoading(true);
    try{

      var itemModel = {
        "barcode": barcode.value.text,
        "itemName": itemName.value.text,
        "salePrice": int.parse(sale.value.text),
        "purchasePrice": int.parse(cost.value.text),
        "discount": int.parse(discount.value.text),
        "category": selectCategory.value,
        "tax": int.parse(tax.value.text),
        "companyName": selectCompany.value,
      };
      await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("items").doc(ItemId).update(itemModel).then((value){
        Utils.flutterToast("Update Product");
        loading.setLoading(false);
        Get.back();
      }).onError((error, stackTrace){
        loading.setLoading(false);
      });
    }catch(e){
      loading.setLoading(false);
    }
  }


  categoryDropdown()async{
    var category = await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("categori").get();
    dropdownCategory.value = category.docs.map((doc) => doc['category'] as String).toList();
  }

  companyDropdown() async {
    var supplier = await  FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("supplier").get();
    dropdownCompany.value = supplier.docs.map((doc) => doc['companyName'] as String).toList();
    print(dropdownCompany); // Debug: Check if data is populated
  }


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    categoryDropdown();
    companyDropdown();
  }
}