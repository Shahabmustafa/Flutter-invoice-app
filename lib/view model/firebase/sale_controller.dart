import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../res/app_api/app_api_service.dart';

class SaleController extends GetxController{


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

  addSale(){
    try{

    }catch(e){
      
    }
  }

}