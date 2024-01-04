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
  addItemData(String companyName,String category)async{
    loading.setLoading(true);
    try{
      ItemModel itemModel = ItemModel(
        itemName: itemName.value.text,
        sale: sale.value.text,
        cost: cost.value.text,
        wholeSale: wholeSale.value.text,
        stock: [
          stock.value.text,
        ],
        categori: category,
        tax: tax.value.text,
        companyName: companyName,
        saleDate: saleDate.value.text,
        expiryDate: expiryDate.value.text,
      );
      await AppApiService.item.doc(itemName.value.text).set(itemModel.toJson()).then((value){
        loading.setLoading(false);
        Get.back();
      }).onError((error, stackTrace){
        loading.setLoading(false);
      });
    }catch(e){
      loading.setLoading(false);
    }
  }

  editItem(String companyName,String itemId,String categoriName)async{
    loading.setLoading(true);
    try{
      ItemModel itemModel = ItemModel(
        itemName: itemName.value.text,
        sale: sale.value.text,
        cost: cost.value.text,
        wholeSale: wholeSale.value.text,
        stock: [
          stock.value.text,
        ],
        categori: categoriName,
        tax: tax.value.text,
        companyName: companyName,
        saleDate: saleDate.value.text,
        expiryDate: expiryDate.value.text,
      );
      await AppApiService.item.doc(itemId).update(itemModel.toJson()).then((value){
        loading.setLoading(false);
        Get.back();
      }).onError((error, stackTrace){
        loading.setLoading(false);
      });
    }catch(e){
      loading.setLoading(false);
    }
  }


  Future<List<String>> companyNameGetDataDropDown() async {
    List<String> dropdownItems = [];
    try {
      QuerySnapshot querySnapshot = await AppApiService.supplier.get();
      if (querySnapshot.docs.isNotEmpty) {
        dropdownItems = querySnapshot.docs.map((doc) => doc['companyName'].toString()).toList();
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
    return dropdownItems;
  }

  Future<List<String>> categoriGetDataDropDown() async {
    List<String> dropdownItems = [];
    try {
      QuerySnapshot querySnapshot = await AppApiService.categori.get();
      if (querySnapshot.docs.isNotEmpty) {
        dropdownItems = querySnapshot.docs.map((doc) => doc['category'].toString()).toList();
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
    return dropdownItems;
  }

}