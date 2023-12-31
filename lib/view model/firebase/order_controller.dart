import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_invoice_app/model/order_model.dart';
import 'package:flutter_invoice_app/view%20model/loading_controller.dart';
import 'package:get/get.dart';

import '../../res/app_api/app_api_service.dart';

class OrderController extends GetxController{

  Rx<TextEditingController> sale = TextEditingController().obs;
  Rx<TextEditingController> cost = TextEditingController().obs;
  Rx<TextEditingController> wholeSale = TextEditingController().obs;
  Rx<TextEditingController> discount = TextEditingController().obs;
  Rx<TextEditingController> Tax = TextEditingController().obs;
  Rx<TextEditingController> Stock = TextEditingController().obs;
  
  
  final loading = Get.put(LoadingController());

  addOrder(String itemName,String companyName,String type)async{
    OrderModel orderModel = OrderModel(
      itemName: itemName,
      companyName: companyName,
      sale: sale.value.text,
      cost: cost.value.text,
      wholeSale: wholeSale.value.text,
      discount: discount.value.text,
      Tax: Tax.value.text,
      Stock: Stock.value.text,
      type: type,
    );
    loading.setLoading(true);
    try{
      await AppApiService.order.add(orderModel.toJson()).then((value){
        AppApiService.dashboard.set({});
        
        loading.setLoading(false);
      }).onError((error, stackTrace){
        loading.setLoading(false);
      });
    }catch(e){
      loading.setLoading(false);
    }
  }



  Future<List<String>> itemsName() async {
    List<String> dropdownItems = [];
    try {
      QuerySnapshot querySnapshot = await AppApiService.item.get();
      if (querySnapshot.docs.isNotEmpty) {
        dropdownItems = querySnapshot.docs.map((doc) => doc['itemName'].toString()).toList();
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
    return dropdownItems;
  }

  Future<List<String>> companysName() async {
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

}