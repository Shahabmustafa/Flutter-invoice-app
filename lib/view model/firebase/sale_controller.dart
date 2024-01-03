import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_invoice_app/model/sale_model.dart';
import 'package:flutter_invoice_app/view%20model/loading_controller.dart';
import 'package:get/get.dart';

import '../../res/app_api/app_api_service.dart';

class SaleController extends GetxController{

  final sale = TextEditingController().obs;
  final quantity = TextEditingController().obs;
  final total = TextEditingController().obs;
  final receivePayment = TextEditingController().obs;
  final duePayment = TextEditingController().obs;
  final loading = Get.put(LoadingController());


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

  addSale(String itemName,String customerName,){
    SaleModel saleModel = SaleModel(
      itemName: itemName,
      sale: sale.value.text,
      quantity: quantity.value.text,
      total: total.value.text,
      customerName: customerName,
      receivePayment: receivePayment.value.text,
      duePayment: duePayment.value.text,
    );
    loading.setLoading(true);
    try{
      AppApiService.sale.add(saleModel.toJson()).then((value){
        AppApiService.dashboard.update({
          "cashSaleAmount" : FieldValue.arrayUnion(
              [
                receivePayment.value.text,
              ]
          ),
        });
        AppApiService.dashboard.update({
          "creditSale" : FieldValue.arrayUnion(
              [
                duePayment.value.text,
              ]
          ),
        });
        AppApiService.customer.doc(customerName).update({
          "payment" : FieldValue.arrayUnion(
            [
              duePayment.value.text,
            ]
          ),
        }).then((value){
          loading.setLoading(false);
        }).onError((error, stackTrace){
          loading.setLoading(false);
        });
        loading.setLoading(false);
      }).onError((error, stackTrace){
        print(error);
        loading.setLoading(false);
      });
    }catch(e){
      print(e);
      loading.setLoading(false);
    }
  }

}