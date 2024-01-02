import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/calculation/calculation.dart';
import 'package:flutter_invoice_app/res/routes/routes.dart';
import 'package:get/get.dart';

import '../../../../res/app_api/app_api_service.dart';
import '../../../../res/colors/app_colors.dart';
import '../../../../res/component/app_button.dart';
import '../../../../res/component/text_widget.dart';

class OrderDetail extends StatefulWidget {
  const OrderDetail({Key? key}) : super(key: key);

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {

  var orderData = Get.arguments;

  final multiply = Calculation();


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Detail"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: Container(
          height: size.height * 0.57,
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
                title: "Item Name",
                subtitle: orderData[0],
              ),
              Divider(),
              TextWidgets(
                title: "Company Name",
                subtitle: orderData[1],
              ),
              Divider(),
              TextWidgets(
                title: "Sale",
                subtitle: orderData[2],
              ),
              Divider(),
              TextWidgets(
                title: "Cost",
                subtitle: orderData[3],
              ),
              Divider(),
              TextWidgets(
                title: "Whole Sale",
                subtitle: orderData[4],
              ),
              Divider(),
              TextWidgets(
                title: "Discount",
                subtitle: orderData[5],
              ),
              Divider(),
              TextWidgets(
                title: "Tax",
                subtitle: orderData[6],
              ),
              Divider(),
              TextWidgets(
                title: "Stocks",
                subtitle: orderData[7],
              ),
              Divider(),
              TextWidgets(
                title: "Type",
                subtitle: orderData[8],
              ),
              Divider(),
              TextWidgets(
                title: "Total",
                subtitle: multiply.doubleConvertInt(multiply.multiply(orderData[3], orderData[7])),
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
                      Get.toNamed(
                        AppRoutes.editOrder,
                        arguments: [
                          orderData[9],
                        ]
                      );
                    },
                  ),
                  AppButton(
                    title: "Delete",
                    height: size.height * 0.05,
                    width: size.width * 0.3,
                    color: AppColor.errorColor,
                    onTap: (){
                      Get.defaultDialog(
                        title: "Delete",
                        content: Text("You Delete This Item"),
                        onConfirm: (){
                          AppApiService.item.doc(orderData[9]).delete().then((value){
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
