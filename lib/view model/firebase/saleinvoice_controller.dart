import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_invoice_app/model/customer_model.dart';
import 'package:flutter_invoice_app/model/product_model.dart';
import 'package:flutter_invoice_app/res/app_api/app_api_service.dart';
import 'package:get/get.dart';

class SaleInvoiceController extends GetxController{

  RxBool loading = false.obs;

  setLoading(bool value){
    loading.value = value;
  }

  RxList<String> dropdownCustomer = <String>[].obs;
  RxList<String> dropdownCustomerIds = <String>[].obs;
  RxString selectCustomer = "".obs;
  RxString selectCustomerId = "".obs;
  TextEditingController receivedAmount =  TextEditingController();


  addSaleInvoice(
      List<Product> product,
      int subTotal,
      int totalAmount,
      int tax,
      int discount,
      )async{
    setLoading(true);
    try{
      var SaleId = await AppApiService.sale.doc();
      var invoiceSnapshot = await AppApiService.sale.orderBy("invoiceId", descending: true).limit(1).get();

      int lastInvoiceId = 1;

      if (invoiceSnapshot.docs.isNotEmpty) {
        lastInvoiceId = invoiceSnapshot.docs.first.data()['invoiceId'] ?? 1;
      }

      int newInvoiceId = lastInvoiceId + 1;

      int dueAmount = totalAmount - int.parse(receivedAmount.text);

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
        "received_amount" : receivedAmount.text,
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
        "received_amount" : receivedAmount.text,
        "due_amount" : dueAmount,
      };
      selectCustomerId.value.isEmpty ? dashboardAddCash(totalAmount) : dashboardAddCredit(dueAmount);
      selectCustomerId.value.isEmpty ? cashInHand() : customer(dueAmount);
      AppApiService.sale.doc(SaleId.id).set(data);
      for (var product in product) {
        await removeStockToProduct(
          itemId: product.productId,
          stock: -product.stock,
        );
      }
      product.clear();
      receivedAmount.clear();
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
    var item = await AppApiService.item.doc(itemId).get();

    if (item.exists) {
      int previousStock = item.data()?['stock'] ?? 0;

      // Decrement stock
      int newStock = previousStock + stock;

      // Ensure stock does not go below 0
      if (newStock < 0) newStock = 0;

      await AppApiService.item.doc(itemId).update({
        "stock": newStock,
      });

      print("Stock updated for $itemId. Previous: $previousStock, New: $newStock");
    } else {
      print("Item not found for itemId: $itemId");
    }
  }

  dashboardAddCash(int totalAmount)async{
    var dashboard = await AppApiService.dashboard.get();
    if(dashboard.exists){
      int previousCashSale = dashboard.data()?['cashSale'] ?? 0;

      await AppApiService.dashboard.update({
        "cashSale" : previousCashSale + totalAmount,
      });
    }else{
      print("dashboard cash sale not found");
    }
  }

  Future customerDropdown() async {
    var customer = await AppApiService.customer.get();
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
      "cashInHand" :  cash.data()?['cashInHand'] + int.parse(receivedAmount.text),
    });

  }

  dashboardAddCredit(int dueAmount)async{
    var dashboard = await AppApiService.dashboard.get();
    if(dashboard.exists){
      int previousCashSale = dashboard.data()?['creditSale'] ?? 0;

      await AppApiService.dashboard.update({
        "creditSale" : previousCashSale + dueAmount,
      });
    }else{
      print("dashboard credit Sale not found");
    }
  }


  customer(int dueAmount)async{
    var customer = await AppApiService.customer.doc(selectCustomerId.value).get();
    AppApiService.customer.doc(selectCustomerId.value).update({
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