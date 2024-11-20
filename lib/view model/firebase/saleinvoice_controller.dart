import 'package:flutter_invoice_app/model/product_model.dart';
import 'package:flutter_invoice_app/res/app_api/app_api_service.dart';
import 'package:get/get.dart';

class SaleInvoiceController extends GetxController{

  RxBool loading = false.obs;

  setLoading(bool value){
    loading.value = value;
  }

  addSaleInvoice(List<Product> product,String subTotal,String totalAmount,String tax,String discount)async{
    setLoading(true);
    try{
      var invoiceId = await AppApiService.sale.doc();
      var data = {
        "invoiceId" : invoiceId.id,
        "productList": product.map((p) => p.toMap()).toList(),
        "subTotal" : subTotal,
        "totalAmount" : totalAmount,
        "tax" : tax,
        "discount" : discount,
      };
      AppApiService.sale.doc(invoiceId.id).set(data);
      product.clear();
      Get.back();
      setLoading(false);
    }catch(e){
      setLoading(false);
    }
  }
}