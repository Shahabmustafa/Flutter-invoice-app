import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_invoice_app/model/item_model.dart';
import 'package:flutter_invoice_app/res/app_api/app_api_service.dart';
import 'package:flutter_invoice_app/view%20model/loading_controller.dart';
import 'package:get/get.dart';

class ItemController extends GetxController{

  final Rx<List<ItemModel>> _itemList = Rx<List<ItemModel>>([]);
  List<ItemModel> get itemList => _itemList.value;


  RxList<String> dropdownCategory = <String>[].obs;
  RxList<String> dropdownCompany = <String>[].obs;
  RxString selectCompany = "".obs;
  RxString selectCategory = "".obs;


  final barcode = TextEditingController().obs;
  final itemName = TextEditingController().obs;
  final sale = TextEditingController().obs;
  final cost = TextEditingController().obs;
  final discount = TextEditingController().obs;
  final stock = TextEditingController().obs;
  final categori = TextEditingController().obs;
  final tax = TextEditingController().obs;
  final saleDate = TextEditingController().obs;
  final expiryDate = TextEditingController().obs;

  final loading = Get.put(LoadingController());



  // items add data in Firebase Data base
  addItemData()async{
    loading.setLoading(true);
    try{
      var itemId = await AppApiService.item.doc();
      ItemModel itemModel = ItemModel(
        barcode: barcode.value.text,
        itemId: itemId.id,
        itemName: itemName.value.text,
        salePrice: int.parse(sale.value.text),
        purchasePrice: int.parse(cost.value.text),
        discount: int.parse(discount.value.text),
        stock: 0,
        category: selectCategory.value,
        tax: int.parse(tax.value.text),
        companyName: selectCompany.value,
        saleDate: saleDate.value.text,
        expiryDate: expiryDate.value.text,
      );
      await AppApiService.item.add(itemModel.toJson()).then((value){
        loading.setLoading(false);
        Get.back();
      }).onError((error, stackTrace){
        loading.setLoading(false);
      });
    }catch(e){
      loading.setLoading(false);
    }
  }

  editItem(String itemId)async{
    loading.setLoading(true);
    try{
      ItemModel itemModel = ItemModel(
        itemName: itemName.value.text,
        salePrice: int.parse(sale.value.text),
        purchasePrice: int.parse(cost.value.text),
        discount: int.parse(discount.value.text),
        stock: 0,
        category: selectCategory.value,
        tax: int.parse(tax.value.text),
        companyName: selectCompany.value,
        saleDate: saleDate.value.text,
        expiryDate: expiryDate.value.text,
      );
      await AppApiService.item.doc(itemId).update(itemModel.toJson()).then((value){
        loading.setLoading(false);
        Get.back();
      }).onError((error, stackTrace){
        loading.setLoading(false);
      });
    }catch(e){
      loading.setLoading(false);
    }
  }


  categoryDropdown()async{
    var category = await AppApiService.categori.get();
    dropdownCategory.value = category.docs.map((doc) => doc['category'] as String).toList();
  }

  companyDropdown() async {
    var supplier = await AppApiService.supplier.get();
    dropdownCompany.value = supplier.docs.map((doc) => doc['companyName'] as String).toList();
    print(dropdownCompany); // Debug: Check if data is populated
  }


  Future<void> scanQRCode() async {
    try {
      String qrCode = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", // Color of the scan line
        "Cancel", // Text for the cancel button
        true, // Whether to show the flashlight button
        ScanMode.QR, // Scan mode: QR code
      );
      if (qrCode != "-1") {
          barcode.value.text = qrCode;
      }
    } catch (e) {
      print("Error scanning QR code: $e");
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    categoryDropdown();
    companyDropdown();
  }
}