import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_invoice_app/model/product_model.dart';
import 'package:flutter_invoice_app/model/supplier_model.dart';
import 'package:get/get.dart';

import '../../res/calculation/calculation.dart';

class OrderController extends GetxController{

  RxBool loading = false.obs;

  setLoading(bool value){
    loading.value = value;
  }

  RxList<String> dropdownCompany = <String>[].obs;
  RxList<String> dropdownCompanyId = <String>[].obs;
  RxString selectCompany = "".obs;
  RxString selectCompanyId = "".obs;
  TextEditingController payAmount =  TextEditingController();


  addOrderInvoice(
      List<Product> product,
      int subTotal,
      int totalAmount,
      int tax,
      int discount,
      )async{
    setLoading(true);
    try{
      var orderId = await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("orders").doc();
      var invoiceSnapshot = await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("orders").orderBy("invoiceId", descending: true).limit(1).get();

      int lastInvoiceId = 1;

      if (invoiceSnapshot.docs.isNotEmpty) {
        lastInvoiceId = invoiceSnapshot.docs.first.data()['invoiceId'] ?? 1;
      }

      int newInvoiceId = lastInvoiceId + 1;

      int dueAmount = totalAmount - int.parse(payAmount.text);

      var data =  {
        "invoiceId" : newInvoiceId,
        "orderId" : orderId.id,
        "productList": product.map((p) => p.toMap()).toList(),
        "subTotal" : subTotal,
        "totalAmount" : totalAmount,
        "tax" : tax,
        "discount" : discount,
        "date" : DateTime.now(),
        "company" : selectCompany.value,
        "received_amount" : payAmount.value.text,
        "due_amount" : dueAmount,
      };
      dashboardAddSupplierPayment(dueAmount);
      subtractCashInHand();
      companyAddPayment(dueAmount);
      FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("orders").doc(orderId.id).set(data);
      for (var product in product) {
        await addStockToProduct(
          itemId: product.productId,
          stock: product.stock,
        );
      }
      product.clear();
      payAmount.clear();
      selectCompanyId.value = "";
      selectCompany.value = "";
      Get.back();
      Get.back();
      setLoading(false);
    }catch(e){
      setLoading(false);
    }
  }

  Future<void> addStockToProduct({required String itemId, required int stock}) async {
    var item = await FirebaseFirestore.instance.collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("items").doc(itemId).get();

    if (item.exists) {
      int previousStock = item.data()?['stock'] ?? 0;

      // Decrement stock
      int newStock = previousStock + stock;

      // Ensure stock does not go below 0
      if (newStock < 0) newStock = 0;

      await FirebaseFirestore.instance.collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("items").doc(itemId).update({
        "stock": newStock,
      });

      print("Stock updated for $itemId. Previous: $previousStock, New: $newStock");
    } else {
      print("Item not found for itemId: $itemId");
    }
  }

  dashboardAddSupplierPayment(int dueAmount)async{
    var dashboard = await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("dashboard").doc(Calculation().date()).get();
    if(dashboard.exists){
      int previousSupplerPayment = dashboard.data()?['supplierPayment'] ?? 0;

      await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("dashboard").doc(Calculation().date()).update({
        "supplierPayment" : previousSupplerPayment + dueAmount,
      });
    }else{
      print("dashboard cash sale not found");
    }
  }

  subtractCashInHand()async{
    var cashInHand = await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();
    FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update({
      "cashInHand" : cashInHand.data()!["cashInHand"] - int.parse(payAmount.text),
    });
  }

  Future company() async {
    var company = await  FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("supplier").get();
    dropdownCompany.value = company.docs.map((doc) {
      SupplierModel companyModel = SupplierModel.fromJson(doc.data() as Map<String, dynamic>);
      dropdownCompanyId.add(companyModel.supplierId ?? '');
      return companyModel.companyName ?? '';
    }).toList();
    print(dropdownCompany);
    print(dropdownCompanyId);
  }


  companyAddPayment(int dueAmount)async{
    var customer = await  FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("supplier").doc(selectCompanyId.value).get();
    FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("supplier").doc(selectCompanyId.value).update({
      "payment" : customer.data()?['payment'] + dueAmount,
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    company();
  }
}