import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_invoice_app/model/customer_model.dart';
import 'package:flutter_invoice_app/view%20model/loading_controller.dart';
import 'package:get/get.dart';

class CustomerController extends GetxController{

  final customerName = TextEditingController().obs;
  final customerEmail = TextEditingController().obs;
  final customerPhone = TextEditingController().obs;
  final customerAddress = TextEditingController().obs;
  final customerPayment = TextEditingController().obs;
  final customerCNIC = TextEditingController().obs;
  final customerCategory = TextEditingController().obs;
  RxBool _loading = false.obs;
  RxBool get loading => _loading;

  setLoading(bool value){
    _loading.value = value;
  }
  addCustomerData()async{
    var customerId = await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("customer").doc();
    CustomerModel customerModel = CustomerModel(
      customerId: customerId.id,
      customerName: customerName.value.text,
      email: customerEmail.value.text,
      phoneNumber: customerPhone.value.text,
      address: customerAddress.value.text,
      payment: 0,
      cnic: customerCNIC.value.text,
      category: customerCategory.value.text,
    );
    setLoading(true);
    try{
      await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("customer").doc(customerId.id).set(customerModel.toJson()).then((value){
        setLoading(false);
        Get.back();
      }).onError((error, stackTrace){
        setLoading(false);
      });
    }catch(e){
      setLoading(false);
    }
  }
}