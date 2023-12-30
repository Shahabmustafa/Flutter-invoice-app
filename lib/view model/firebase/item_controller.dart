import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/model/item_model.dart';
import 'package:flutter_invoice_app/res/app_api/app_api_service.dart';
import 'package:flutter_invoice_app/view%20model/loading_controller.dart';
import 'package:get/get.dart';

class ItemController extends GetxController{

  final Rx<List<ItemModel>> _itemList = Rx<List<ItemModel>>([]);
  List<ItemModel> get itemList => _itemList.value;


  final itemName = TextEditingController().obs;
  final sale = TextEditingController().obs;
  final cost = TextEditingController().obs;
  final wholeSale = TextEditingController().obs;
  final stock = TextEditingController().obs;
  final categori = TextEditingController().obs;
  final tax = TextEditingController().obs;
  final saleDate = TextEditingController().obs;
  final expiryDate = TextEditingController().obs;

  final loading = Get.put(LoadingController());



  // items add data in Firebase Data base
  addItemData(String companyName)async{
    loading.setLoading(true);
    try{
      ItemModel itemModel = ItemModel(
        itemName: itemName.value.text,
        sale: sale.value.text,
        cost: cost.value.text,
        wholeSale: wholeSale.value.text,
        stock: stock.value.text,
        categori: categori.value.text,
        tax: tax.value.text,
        companyName: companyName,
        saleDate: saleDate.value.text,
        expiryDate: expiryDate.value.text,
      );
      await AppApiService.item.add(itemModel.toJson()).then((value){
        loading.setLoading(false);
        Get.back();
      }).onError((error, stackTrace){
        loading.setLoading(false);
      });
    }catch(e){
      loading.setLoading(false);
    }
  }

  // static Future<List<ItemModel>> searchItem(String itamName)async{
  //   final snapshot = await AppApiService.item.where("itemName",isGreaterThanOrEqualTo: itamName).get();
  //   return snapshot.docs.map((doc) => ItemModel.fromJson(doc.data())).toList();
  // }

  // items get data in Firebase Database
  // @override
  // void onInit() {
  //   // TODO: implement onInit
  //   super.onInit();
  //   _itemList.bindStream(AppApiService.item.snapshots().map((QuerySnapshot querySnapshot){
  //     List<ItemModel> relVale = [];
  //     for(var element in querySnapshot.docs){
  //       relVale.add(ItemModel.fromSnap(element));
  //     }
  //     return relVale;
  //   }));
  // }

}