import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_invoice_app/model/sale_model.dart';
import 'package:get/get.dart';

import '../../res/app_api/app_api_service.dart';

class SaleController extends GetxController{

  final sale = TextEditingController().obs;
  final quantity = TextEditingController().obs;
  final total = TextEditingController().obs;
  final receivePayment = TextEditingController().obs;


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

  Future<List<String>> customerName() async {
    List<String> dropdownItems = [];
    try {
      QuerySnapshot querySnapshot = await AppApiService.customer.get();
      if (querySnapshot.docs.isNotEmpty) {
        dropdownItems = querySnapshot.docs.map((doc) => doc['customerName'].toString()).toList();
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
    return dropdownItems;
  }

  addSale(String itemName,String customerName,String total,String duePayment){
    SaleModel saleModel = SaleModel(
      itemName: itemName,
      sale: sale.value.text,
      quantity: quantity.value.text,
      total: total,
      customerName: customerName,
      receivePayment: receivePayment.value.text,
      duePayment: duePayment,
    );
    try{

    }catch(e){

    }
  }

}