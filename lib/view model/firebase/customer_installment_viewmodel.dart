
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../model/customer_model.dart';
import '../../res/calculation/calculation.dart';

class CustomerInstallmentViewModel extends GetxController {
  RxList<String> dropdownCustomer = <String>[].obs;
  RxList<String> dropdownCustomerIds = <String>[].obs;
  RxList<String> dropdownCustomerPayment = <String>[].obs;
  RxString selectCustomer = "".obs;
  RxString selectCustomerId = "".obs;
  RxString selectCustomerPayment = "".obs;

  RxBool _loading = false.obs;
  RxBool get loading => _loading;

  TextEditingController recivedAmount = TextEditingController();

  setLoading(bool value){
    _loading.value = value;
  }
  
  @override
  void onInit() {
    super.onInit();
    customerDropdown();
  }

  Future customerDropdown() async {
    var customer = await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("customer").get();
    dropdownCustomer.value = customer.docs.map((doc) {
      CustomerModel customerModel = CustomerModel.fromJson(doc.data() as Map<String, dynamic>);
      dropdownCustomerIds.add(customerModel.customerId ?? '',);
      dropdownCustomerPayment.add(customerModel.payment?.toString() ?? '',);
      return customerModel.customerName ?? '';
    }).toList();
    print(dropdownCustomer);
    print(dropdownCustomerIds);
    print(dropdownCustomerPayment);
  }
  
  customerInstallment()async{
   try{
     setLoading(true);
     var snapshot = await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("customer").doc(selectCustomerId.value).get();
     var dashboard = await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("dashboard").doc(Calculation().date()).get();
     var user = await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();
     FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("customer").doc(selectCustomerId.value).update({
       "payment" : snapshot.data()!["payment"] - int.parse(recivedAmount.text),
     });

     FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("customerInstallment").add({
       "customerName" : selectCustomer.value,
       "payBalance" : recivedAmount.text.trim(),
       "date" : DateTime.now(),
       "customerId" : selectCustomerId.value,
     });

     FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("dashboard").doc(Calculation().date()).update({
       "totalInstallment" : dashboard.data()!["totalInstallment"] + int.parse(recivedAmount.text),
     });

     FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update({
       "cashInHand" : user.data()!["cashInHand"] + int.parse(recivedAmount.text),
     });
     await customerDropdown();
     setLoading(false);
     recivedAmount.clear();
     selectCustomerId.value = "";
     selectCustomer.value = "";
     selectCustomerPayment.value = "";
     Get.back();
   }catch(e){
     setLoading(false);
   }
  }


}