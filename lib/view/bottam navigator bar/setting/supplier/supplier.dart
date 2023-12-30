import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/routes/routes.dart';
import 'package:get/get.dart';

import '../../../../res/app_api/app_api_service.dart';
import '../../../../res/colors/app_colors.dart';
import '../../../../res/component/app_button.dart';
import '../../../../res/component/text_widget.dart';

class SupplierScreen extends StatefulWidget {
  const SupplierScreen({Key? key}) : super(key: key);

  @override
  State<SupplierScreen> createState() => _SupplierScreenState();
}

class _SupplierScreenState extends State<SupplierScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Supplier"),
      ),
      body: StreamBuilder(
        stream: AppApiService.supplier.snapshots(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context,index){
                var item = snapshot.data!.docs[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  child: Container(
                    height: size.height * 0.26,
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
                          subtitle: item["companyName"],
                        ),
                        TextWidgets(
                          title: "Company Email",
                          subtitle: item["companyEmail"],
                        ),
                        TextWidgets(
                          title: "Company Phone Number",
                          subtitle: item["phoneNumber"],
                        ),
                        TextWidgets(
                          title: "Company Address",
                          subtitle: item["address"],
                        ),
                        TextWidgets(
                          title: "Supplier Name",
                          subtitle: item["supplierName"],
                        ),
                        TextWidgets(
                          title: "Supplier Phone Number",
                          subtitle: item["supplierPhoneNumber"],
                        ),
                        TextWidgets(
                          title: "Supplier Email",
                          subtitle: item["supplieremail"],
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppButton(
                              title: "Edit",
                              height: size.height * 0.03,
                              width: size.width * 0.2,
                              color: Colors.green,
                              onTap: (){

                              },
                            ),
                            AppButton(
                              title: "Delete",
                              height: size.height * 0.03,
                              width: size.width * 0.2,
                              color: AppColor.errorColor,
                              onTap: (){
                                Get.defaultDialog(
                                  title: "Delete",
                                  content: Text("You Delete This Item"),
                                  onConfirm: (){
                                    AppApiService.supplier.doc(snapshot.data!.docs[index].id).delete().then((value) => Get.back());
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
                );
              },
            );
          }else{
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.toNamed(AppRoutes.addSupplier);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
