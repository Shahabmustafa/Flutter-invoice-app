import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/routes/routes.dart';
import 'package:get/get.dart';

import '../../../../res/colors/app_colors.dart';
import '../../../../res/component/app_button.dart';
import '../../../../res/component/text_widget.dart';

class SupplierDetail extends StatefulWidget {
  const SupplierDetail({Key? key}) : super(key: key);

  @override
  State<SupplierDetail> createState() => _SupplierDetailState();
}

class _SupplierDetailState extends State<SupplierDetail> {

  var supplier = Get.arguments;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Supplier Detail"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: Container(
          height: size.height * 0.6,
          width: size.width,
          padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 0.08,
                spreadRadius: 0.8,
                offset: Offset(1,1),
              ),
            ],
          ),
          child: Column(
            children: [
              TextWidgets(
                title: "Company Name",
                subtitle: supplier[0],
              ),
              Divider(),
              TextWidgets(
                title: "Company Email",
                subtitle: supplier[1],
              ),
              Divider(),
              TextWidgets(
                title: "Company Phone No",
                subtitle: supplier[2],
              ),
              Divider(),
              TextWidgets(
                title: "Address",
                subtitle: supplier[3],
              ),
              Divider(),
              TextWidgets(
                title: "Supplier Name",
                subtitle: supplier[4],
              ),
              Divider(),
              TextWidgets(
                title: "Supplier Phone Number",
                subtitle: supplier[5],
              ),
              Divider(),
              TextWidgets(
                title: "Supplier Email",
                subtitle: supplier[6],
              ),
              Divider(),
              TextWidgets(
                title: "Payment",
                subtitle: supplier[7],
              ),
              Divider(),
              SizedBox(
                height: size.height * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppButton(
                    title: "Delete",
                    height: size.height * 0.05,
                    width: size.width * 0.3,
                    color: AppColor.whiteColor,
                    textColor: AppColor.primaryColor,
                    onTap: (){
                      FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("supplier").doc(supplier[8]).delete().then((value){
                        Get.back();
                      });
                    },
                  ),
                  AppButton(
                    title: "Edit",
                    height: size.height * 0.05,
                    width: size.width * 0.3,
                    color: AppColor.primaryColor,
                    textColor: AppColor.whiteColor,
                    onTap: (){
                      Get.toNamed(
                        AppRoutes.editSupplier,
                        arguments: [
                          supplier[0],
                          supplier[1],
                          supplier[2],
                          supplier[3],
                          supplier[4],
                          supplier[5],
                          supplier[6],
                          supplier[7],
                          supplier[8],
                        ],
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
