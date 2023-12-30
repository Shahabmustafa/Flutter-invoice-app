import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../res/app_api/app_api_service.dart';
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
          height: size.height * 0.42,
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
                title: "Company Phone Number",
                subtitle: supplier[2],
              ),
              Divider(),
              TextWidgets(
                title: "Company Address",
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
              SizedBox(
                height: size.height * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppButton(
                    title: "Edit",
                    height: size.height * 0.05,
                    width: size.width * 0.3,
                    color: Colors.green,
                    onTap: (){

                    },
                  ),
                  AppButton(
                    title: "Delete",
                    height: size.height * 0.05,
                    width: size.width * 0.3,
                    color: AppColor.errorColor,
                    onTap: (){
                      print(supplier[7]);
                      AppApiService.item.doc(supplier[7]).delete().then((value){
                        Get.back();
                      });
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
