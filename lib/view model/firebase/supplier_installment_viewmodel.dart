import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_invoice_app/model/supplier_model.dart';
import 'package:get/get.dart';
import '../../res/app_api/app_api_service.dart';
import '../../res/calculation/calculation.dart';

class SupplierInstallmentViewModel extends GetxController {
  RxList<String> dropdownSupplier = <String>[].obs;
  RxList<String> dropdownSupplierIds = <String>[].obs;
  RxList<String> dropdownSupplierPayment = <String>[].obs;
  RxString selectSupplier = "".obs;
  RxString selectSupplierId = "".obs;
  RxString selectSupplierPayment = "".obs;

  TextEditingController recivedAmount = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    SupplierDropdown();
  }

  Future SupplierDropdown() async {
    var Supplier = await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("supplier").get();
    dropdownSupplier.value = Supplier.docs.map((doc) {
      SupplierModel supplierModel = SupplierModel.fromJson(doc.data() as Map<String, dynamic>);
      dropdownSupplierIds.add(supplierModel.supplierId ?? '',);
      dropdownSupplierPayment.add(supplierModel.payment?.toString() ?? '',);
      return supplierModel.supplierName ?? '';
    }).toList();
    print(dropdownSupplier);
    print(dropdownSupplierIds);
    print(dropdownSupplierPayment);
  }

  SupplierInstallment()async{
    var snapshot = await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("supplier").doc(selectSupplierId.value).get();
    var dashboard = await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("dashboard").doc(Calculation().date()).get();
    var user = await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();
    FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("supplier").doc(selectSupplierId.value).update({
      "payment" : snapshot.data()!["payment"] - int.parse(recivedAmount.text),
    });

    FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("supplierInstallment").add({
      "supplierName" : selectSupplier.value,
      "payBalance" : recivedAmount.text.trim(),
      "date" : DateTime.now(),
      "supplierId" : selectSupplierId.value,
    });

    FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("dashboard").doc(Calculation().date()).update({
      "supplierPayment" : dashboard.data()!["supplierPayment"] - int.parse(recivedAmount.text),
    });

    FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update({
      "cashInHand" : user.data()!["cashInHand"] - int.parse(recivedAmount.text),
    });
    await SupplierDropdown();
    recivedAmount.clear();
    selectSupplierId.value = "";
    selectSupplier.value = "";
    selectSupplierPayment.value = "";
    Get.back();

  }


}