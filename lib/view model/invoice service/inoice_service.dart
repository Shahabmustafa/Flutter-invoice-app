import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/model/business_model.dart';
import 'package:flutter_invoice_app/model/payer_model.dart';
import 'package:flutter_invoice_app/res/app_api/app_api_service.dart';
import 'package:flutter_invoice_app/view%20model/image_picker/image_picker_service.dart';
import 'package:get/get.dart';

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
      setLoading(true);
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
    try{
      await AppApiService.invoice.doc(businessId).update({
        "array" : FieldValue.arrayUnion(
          [
            itemName.value.text,
            itemCost.value.text,
            itemQuantity.value.text,
            total,
          ],
        ),
      }).then((value){
        Get.back();
      });
    }catch(e){

    }
  }


}