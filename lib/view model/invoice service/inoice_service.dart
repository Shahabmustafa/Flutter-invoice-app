import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/model/business_model.dart';
import 'package:flutter_invoice_app/model/item_model.dart';
import 'package:flutter_invoice_app/model/payer_model.dart';
import 'package:flutter_invoice_app/res/app_api/app_api_service.dart';
import 'package:flutter_invoice_app/view%20model/image_picker/image_picker_service.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';

import '../../utils/utils.dart';

class InvoiceService extends GetxController{

  Rx<TextEditingController> businessName = TextEditingController().obs;
  Rx<TextEditingController> businessEmail = TextEditingController().obs;
  Rx<TextEditingController> businessNumber = TextEditingController().obs;
  Rx<TextEditingController> businessAddress = TextEditingController().obs;
  Rx<TextEditingController> payerName = TextEditingController().obs;
  Rx<TextEditingController> payerEmail = TextEditingController().obs;
  Rx<TextEditingController> payerNumber = TextEditingController().obs;
  Rx<TextEditingController> payerAddress = TextEditingController().obs;
  Rx<TextEditingController> itemName = TextEditingController().obs;
  Rx<TextEditingController> itemCost = TextEditingController().obs;
  Rx<TextEditingController> itemQuantity = TextEditingController().obs;
  Rx<TextEditingController> note = TextEditingController().obs;
  String? businessId;
  final imagePicker = Get.put(ImagePickerService());

  RxBool loading = false.obs;

  setLoading(bool value){
    loading.value = value;
  }

  businessService(BuildContext context)async{
    setLoading(true);
    firebase_storage.Reference storageRef = firebase_storage.FirebaseStorage.instance.ref("image").child("businessLogo");
    firebase_storage.UploadTask uploadTask = storageRef.putFile(File((imagePicker.imagePath.value.toString())));
    await Future.value(uploadTask);
    final newUrl = await storageRef.getDownloadURL();
    BusinessModel businessModel = BusinessModel(
      businessName: businessName.value.text,
      businessEmail: businessEmail.value.text,
      businessAddress: businessAddress.value.text,
      businessPhone: businessNumber.value.text,
      businessLogo: newUrl,
    );
    try{
      await AppApiService.invoice.add(businessModel.toJson()).then((value)async{
        businessId = value.id;
        setLoading(false);
        Get.back();
      }).onError((error, stackTrace){
        setLoading(false);
      });
    }catch(e){
      setLoading(false);
    }
  }

  payerService(BuildContext context)async{
    PayerModel payerModel = PayerModel(
      payerName: payerName.value.text,
      payerEmail: payerEmail.value.text,
      payerPhone: payerNumber.value.text,
      payerAddress: payerAddress.value.text,
    );
    setLoading(true);
    try{
      await AppApiService.invoice.doc(businessId).update(payerModel.toJson()).then((value){
        setLoading(false);
        Get.back();
      }).onError((error, stackTrace){
        setLoading(false);
      });
    }catch(e){
      setLoading(false);
    }
  }

  paymentService(BuildContext context)async{
    await AppApiService.invoice.doc(businessId).update({
      "paymentDescription" : note.value.text,
    }).then((value){
      note.value.clear();
      Get.back();
    });
  }

  businessItem(BuildContext context)async{
    var a = int.parse(itemCost.value.text);
    var b = int.parse(itemQuantity.value.text);
    var total = a * b;

    ItemModel itemModel = ItemModel(
      itemName: itemName.value.text,
      itemCost: itemCost.value.text,
      itemQuantity: itemQuantity.value.text,
      total: total.toString(),
    );
    try{
      setLoading(true);
      await FirebaseFirestore.instance
          .collection("users")
          .doc(AppApiService.userId)
          .collection("items")
          .add(itemModel.toJson()).then((value){
        setLoading(false);
        itemName.value.clear();
        itemCost.value.clear();
        itemQuantity.value.clear();
        Get.back();
      }).onError((error, stackTrace){
        setLoading(false);
      });
    }catch(e){
      setLoading(false);
    }
  }

  Future<void> uploadSignatureToFirebase(SignatureController _controller) async {
    setLoading(true);
    try {
      // Convert signature to image
      ui.Image? image = await _controller.toImage(
        width: 250,
        height: 250,
        // color: Colors.black,
        // size: Size(200.0, 100.0),
      );
      ByteData? byteData = await image!.toByteData(format: ui.ImageByteFormat.png);
      Uint8List imageData = byteData!.buffer.asUint8List();
      // Upload image data to Firebase Storage
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref(businessId).child("signature");
      UploadTask uploadTask = ref.putData(imageData);
      await uploadTask.whenComplete(() => null);

      String imageUrl = await ref.getDownloadURL();

      Utils.flutterToast('Signature uploaded to Firebase Storage: $imageUrl');

      await AppApiService.invoice.doc(businessId).update({
        "signature" : imageUrl,
      }).then((value){
        setLoading(false);
        _controller.clear();
      }).onError((error, stackTrace){
        setLoading(false);
      });
    } catch (e) {
      setLoading(false);
      Utils.flutterToast('Error uploading signature: $e');
    }
  }

}