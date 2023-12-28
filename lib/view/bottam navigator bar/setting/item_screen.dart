import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/app_api/app_api_service.dart';
import 'package:flutter_invoice_app/res/colors/app_colors.dart';
import 'package:flutter_invoice_app/res/component/app_button.dart';
import 'package:flutter_invoice_app/res/component/text_widget.dart';
import 'package:flutter_invoice_app/res/routes/routes.dart';
import 'package:flutter_invoice_app/view%20model/firebase/item_controller.dart';
import 'package:get/get.dart';

class ItemScreen extends StatefulWidget {
  const ItemScreen({Key? key}) : super(key: key);

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Items"),
      ),
      body: StreamBuilder(
        stream: AppApiService.item.snapshots(),
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
                          title: "Name",
                          subtitle: item["itemName"],
                        ),
                        TextWidgets(
                          title: "Sale",
                          subtitle: item["sale"],
                        ),
                        TextWidgets(
                          title: "Cost",
                          subtitle: item["cost"],
                        ),
                        TextWidgets(
                          title: "Whole Sale",
                          subtitle: item["wholeSale"],
                        ),
                        TextWidgets(
                          title: "Tax",
                          subtitle: item["tax"],
                        ),
                        TextWidgets(
                          title: "Supplier",
                          subtitle: item["companyName"],
                        ),
                        TextWidgets(
                          title: "Expiry Date",
                          subtitle: item["expiryDate"],
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
                                    AppApiService.item.doc(snapshot.data!.docs[index].id).delete().then((value) => Get.back());
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
          Get.toNamed(AppRoutes.addItems);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
