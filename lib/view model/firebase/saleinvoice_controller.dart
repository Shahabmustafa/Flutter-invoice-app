import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_invoice_app/model/customer_model.dart';
import 'package:flutter_invoice_app/model/product_model.dart';
import 'package:get/get.dart';

import '../../res/calculation/calculation.dart';

class SaleInvoiceController extends GetxController{

  RxBool loading = false.obs;

  setLoading(bool value){
    loading.value = value;
  }

  RxList<String> dropdownCustomer = <String>[].obs;
  RxList<String> dropdownCustomerIds = <String>[].obs;
  RxString selectCustomer = "".obs;
  RxString selectCustomerId = "".obs;
  TextEditingController payAmount =  TextEditingController();


  addSaleInvoice(
      List<Product> product,
      int subTotal,
      int totalAmount,
      int tax,
      int discount,
      )async{
    setLoading(true);
    try{
      var SaleId = await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("saleInvoice").doc();
      var invoiceSnapshot = await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("saleInvoice").orderBy("invoiceId", descending: true).limit(1).get();

      int lastInvoiceId = 1;

      if (invoiceSnapshot.docs.isNotEmpty) {
        lastInvoiceId = invoiceSnapshot.docs.first.data()['invoiceId'] ?? 1;
      }

      int newInvoiceId = lastInvoiceId + 1;

      int dueAmount = totalAmount - int.parse(payAmount.text);

      var data = selectCustomerId.value.isEmpty ?
      {
        "invoiceId" : newInvoiceId,
        "SaleId" : SaleId.id,
        "productList": product.map((p) => p.toMap()).toList(),
        "subTotal" : subTotal,
        "totalAmount" : totalAmount,
        "tax" : tax,
        "discount" : discount,
        "date" : DateTime.now(),
        "received_amount" : payAmount.text,
      }
      : {
        "invoiceId" : newInvoiceId,
        "SaleId" : SaleId.id,
        "productList": product.map((p) => p.toMap()).toList(),
        "subTotal" : subTotal,
        "totalAmount" : totalAmount,
        "tax" : tax,
        "discount" : discount,
        "date" : DateTime.now(),
        "customer" : selectCustomer.value,
        "received_amount" : payAmount.text,
        "due_amount" : dueAmount,
      };
      selectCustomerId.value.isEmpty ? dashboardAddCash(totalAmount) : dashboardAddCredit(dueAmount);
      selectCustomerId.value.isEmpty ? cashInHand() : customer(dueAmount);
      FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("saleInvoice").doc(SaleId.id).set(data);
      for (var product in product) {
        await removeStockToProduct(
          itemId: product.productId,
          stock: -product.stock,
        );
      }
      product.clear();
      payAmount.clear();
      selectCustomerId.value = "";
      selectCustomer.value = "";
      Get.back();
      Get.back();
      setLoading(false);
    }catch(e){
      setLoading(false);
    }
  }

  Future<void> removeStockToProduct({required String itemId, required int stock}) async {
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

  dashboardAddCash(int totalAmount)async{
    var dashboard = await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("dashboard").doc(Calculation().date()).get();
    if(dashboard.exists){
      int previousCashSale = dashboard.data()?['cashSale'] ?? 0;

      await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("dashboard").doc(Calculation().date()).update({
        "cashSale" : previousCashSale + totalAmount,
      });
    }else{
      print("dashboard cash sale not found");
    }
  }

  Future customerDropdown() async {
    var customer = await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("customer").get();
    dropdownCustomer.value = customer.docs.map((doc) {
      CustomerModel customerModel = CustomerModel.fromJson(doc.data() as Map<String, dynamic>);
      dropdownCustomerIds.add(customerModel.customerId ?? '');
      return customerModel.customerName ?? '';
    }).toList();
    print(dropdownCustomer);
    print(dropdownCustomerIds);  // Ensure both lists are populated correctly
  }

  cashInHand()async{
    var cash = await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();
    FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update({
      "cashInHand" :  cash.data()?['cashInHand'] + int.parse(payAmount.text),
    });

  }

  dashboardAddCredit(int dueAmount)async{
    var dashboard = await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("dashboard").doc(Calculation().date()).get();
    var cashInHand = await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();
    if(dashboard.exists){
      int previousCreditSale = dashboard.data()?['creditSale'] ?? 0;
      int previousCashSale = dashboard.data()?['cashSale'] ?? 0;
      var cash =  cashInHand.data()?["cashInHand"];

      await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("dashboard").doc(Calculation().date()).update({
        "creditSale" : previousCreditSale + dueAmount,
        "cashSale" : previousCashSale + int.parse(payAmount.text),
      });

      FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update({
        "cashInHand" : cash + int.parse(payAmount.text),
      });

    }else{
      print("dashboard credit Sale not found");
    }
  }


  customer(int dueAmount)async{
    var customer = await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("customer").doc(selectCustomerId.value).get();
    FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("customer").doc(selectCustomerId.value).update({
      "payment" : customer.data()?['payment'] + dueAmount,
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    customerDropdown();
  }
}