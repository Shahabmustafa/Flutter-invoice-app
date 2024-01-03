import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/routes/routes.dart';
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

  supplierPayment() {
    List<dynamic> supplierPayment = supplier[7];
    int sum = 0;
    for (String amount in supplierPayment) {
      sum += int.tryParse(amount) ?? 0; // Parse string to int, default to 0 if parsing fails
    }
    return sum;
  }
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
          height: size.height * 0.45,
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
              TextWidgets(
                title: "Payment",
                subtitle: supplierPayment().toString(),
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
                          AppRoutes.editSupplier,
                          arguments: [supplier[8]],
                      );
                    },
                  ),
                  AppButton(
                    title: "Delete",
                    height: size.height * 0.05,
                    width: size.width * 0.3,
                    color: AppColor.errorColor,
                    onTap: (){
                      AppApiService.item.doc(supplier[8]).delete().then((value){
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
