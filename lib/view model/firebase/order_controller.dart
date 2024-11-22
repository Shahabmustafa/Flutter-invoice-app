import 'package:flutter/cupertino.dart';
import 'package:flutter_invoice_app/model/customer_model.dart';
import 'package:flutter_invoice_app/model/product_model.dart';
import 'package:flutter_invoice_app/model/supplier_model.dart';
import 'package:flutter_invoice_app/res/app_api/app_api_service.dart';
import 'package:get/get.dart';

class OrderController extends GetxController{

  RxBool loading = false.obs;

  setLoading(bool value){
    loading.value = value;
  }

  RxList<String> dropdownCompany = <String>[].obs;
  RxList<String> dropdownCompanyId = <String>[].obs;
  RxString selectCompany = "".obs;
  RxString selectCompanyId = "".obs;
  TextEditingController receivedAmount =  TextEditingController();


  addOrderInvoice(
      List<Product> product,
      int subTotal,
      int totalAmount,
      int tax,
      int discount,
      )async{
    setLoading(true);
    try{
      var orderId = await AppApiService.order.doc();
      var invoiceSnapshot = await AppApiService.order.orderBy("invoiceId", descending: true).limit(1).get();

      int lastInvoiceId = 1;

      if (invoiceSnapshot.docs.isNotEmpty) {
        lastInvoiceId = invoiceSnapshot.docs.first.data()['invoiceId'] ?? 1;
      }

      int newInvoiceId = lastInvoiceId + 1;

      int dueAmount = totalAmount - int.parse(receivedAmount.text);

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
        "received_amount" : receivedAmount.value.text,
        "due_amount" : dueAmount,
      };
      dashboardAddSupplierPayment(dueAmount);
      companyAddPayment(dueAmount);
      AppApiService.order.doc(orderId.id).set(data);
      for (var product in product) {
        await addStockToProduct(
          itemId: product.productId,
          stock: product.stock,
        );
      }
      product.clear();
      receivedAmount.clear();
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

  dashboardAddSupplierPayment(int dueAmount)async{
    var dashboard = await AppApiService.dashboard.get();
    if(dashboard.exists){
      int previousSupplerPayment = dashboard.data()?['supplierPayment'] ?? 0;

      await AppApiService.dashboard.update({
        "supplierPayment" : previousSupplerPayment + dueAmount,
      });
    }else{
      print("dashboard cash sale not found");
    }
  }

  Future company() async {
    var company = await AppApiService.supplier.get();
    dropdownCompany.value = company.docs.map((doc) {
      SupplierModel companyModel = SupplierModel.fromJson(doc.data() as Map<String, dynamic>);
      dropdownCompanyId.add(companyModel.supplierId ?? '');
      return companyModel.companyName ?? '';
    }).toList();
    print(dropdownCompany);
    print(dropdownCompanyId);
  }


  companyAddPayment(int dueAmount)async{
    var customer = await AppApiService.supplier.doc(selectCompanyId.value).get();
    AppApiService.supplier.doc(selectCompanyId.value).update({
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