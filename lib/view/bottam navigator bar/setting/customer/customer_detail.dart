import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../res/app_api/app_api_service.dart';
import '../../../../res/colors/app_colors.dart';
import '../../../../res/component/app_button.dart';
import '../../../../res/component/text_widget.dart';

class CustomerDetail extends StatefulWidget {
  const CustomerDetail({Key? key}) : super(key: key);

  @override
  State<CustomerDetail> createState() => _CustomerDetailState();
}

class _CustomerDetailState extends State<CustomerDetail> {

  var customerData = Get.arguments;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: Container(
          height: size.height * 0.5,
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
                offset: Offset(0.2,0.2),
              ),
            ],
          ),
          child: Column(
            children: [
              TextWidgets(
                title: "Name",
                subtitle: customerData[0],
              ),
              Divider(),
              TextWidgets(
                title: "Email",
                subtitle: customerData[1],
              ),
              Divider(),
              TextWidgets(
                title: "CNIC",
                subtitle: customerData[5],
              ),
              Divider(),
              TextWidgets(
                title: "Phone No",
                subtitle: customerData[2],
              ),
              Divider(),
              TextWidgets(
                title: "Address",
                subtitle: customerData[3],
              ),
              Divider(),
              TextWidgets(
                title: "Payment",
                subtitle: customerData[4].toString(),
              ),
              Divider(),
              TextWidgets(
                title: "Category",
                subtitle: customerData[6],
              ),
              SizedBox(height: size.height * 0.025,),
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
                      Get.defaultDialog(
                        title: "Delete",
                        content: Text("You Delete This Item"),
                        onConfirm: (){
                          AppApiService.item.doc(customerData[7]).delete().then((value){
                            Get.back();
                            Get.back();
                          });
                        },
                        onCancel: (){
                          Get.back();
                        },

                      );
                    },
                  ),
                  AppButton(
                    title: "Edit",
                    height: size.height * 0.05,
                    width: size.width * 0.3,
                    color: AppColor.primaryColor,
                    textColor: AppColor.whiteColor,
                    onTap: (){},
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
