import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/app_api/app_api_service.dart';
import 'package:flutter_invoice_app/res/component/app_button.dart';
import 'package:flutter_invoice_app/res/component/invoice_text_field.dart';
import 'package:flutter_invoice_app/view%20model/auth%20service/signup_service.dart';
import 'package:get/get.dart';

class ChangeProfileDetail extends StatefulWidget {
  const ChangeProfileDetail({Key? key}) : super(key: key);

  @override
  State<ChangeProfileDetail> createState() => _ChangeProfileDetailState();
}

class _ChangeProfileDetailState extends State<ChangeProfileDetail> {

  TextEditingController userName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();

  final reLoad = Get.put(SignUpService());

  Future<void> updateProfile()async{
    reLoad.setLoading(true);
    try{
      await FirebaseFirestore.instance
          .collection("users")
          .doc(AppApiService.userId)
          .update({
        "userName" : userName.text,
        "phoneNumber" : phoneNumber.text,
      }).then((value){
        reLoad.setLoading(false);
        Get.back();
      }).onError((error, stackTrace){
        reLoad.setLoading(false);
      });
    }catch(e){
      reLoad.setLoading(false);
    }
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Profile"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InvoiceTextField(
            title: "Name",
            controller: userName,
          ),
          SizedBox(
            height: 20,
          ),
          InvoiceTextField(
            title: "Phone Number",
            controller: phoneNumber,
          ),
          SizedBox(
            height: size.height * 0.04,
          ),
          AppButton(
            height: size.height * 0.05,
            width: size.width * 0.95,
            title: "Update",
            loading: reLoad.loading.value,
            onTap: (){
              updateProfile();
            },
          ),
        ],
      ),
    );
  }
}
