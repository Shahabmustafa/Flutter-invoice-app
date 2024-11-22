import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/routes/routes.dart';
import 'package:get/get.dart';

import '../../../../res/app_api/app_api_service.dart';
import '../../../../res/colors/app_colors.dart';
import '../../../../res/component/app_button.dart';
import '../../../../res/component/text_widget.dart';

class ItemDetail extends StatefulWidget {
  const ItemDetail({Key? key}) : super(key: key);

  @override
  State<ItemDetail> createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {

  var itemData = Get.arguments;


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Item Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: Container(
          height: size.height * 0.73,
          width: size.width,
          padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade400,
                blurRadius: 0.8,
                spreadRadius: 0.5,
                offset: Offset(0.2,0.2),
              ),
            ],
          ),
          child: Column(
            children: [
              TextWidgets(
                title: "Barcode",
                subtitle: itemData[10],
              ),
              Divider(),
              TextWidgets(
                title: "Name",
                subtitle: itemData[3],
              ),
              Divider(),
              TextWidgets(
                title: "Sale Price",
                subtitle: itemData[6],
              ),
              Divider(),
              TextWidgets(
                title: "Purchase Price",
                subtitle: itemData[4],
              ),
              Divider(),
              TextWidgets(
                title: "Discount",
                subtitle: itemData[9] + " %",
              ),
              Divider(),
              TextWidgets(
                title: "Tax",
                subtitle: "${itemData[8]} %",
              ),
              Divider(),
              TextWidgets(
                title: "Stock",
                subtitle: itemData[7],
              ),
              Divider(),
              TextWidgets(
                title: "Company Name",
                subtitle: itemData[1],
              ),
              Divider(),
              TextWidgets(
                title: "Category",
                subtitle: itemData[0],
              ),
              Divider(),
              TextWidgets(
                title: "Date",
                subtitle: itemData[5],
              ),
              Divider(),
              TextWidgets(
                title: "Expiry Date",
                subtitle: itemData[2],
              ),
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
                    textColor: AppColor.blackColor,
                    onTap: (){
                      Get.toNamed(
                        AppRoutes.editItem,
                        arguments: [
                          itemData[10],
                        ],
                      );
                    },
                  ),
                  AppButton(
                    title: "Edit",
                    height: size.height * 0.05,
                    width: size.width * 0.3,
                    color: AppColor.primaryColor,
                    onTap: (){
                      Get.defaultDialog(
                        title: "Delete",
                        content: Text("You Delete This Item"),
                        onConfirm: (){
                          AppApiService.item.doc(itemData[10]).delete().then((value){
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
