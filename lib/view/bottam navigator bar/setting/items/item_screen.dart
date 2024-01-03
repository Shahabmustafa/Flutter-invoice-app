import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/app_api/app_api_service.dart';
import 'package:flutter_invoice_app/res/component/app_button.dart';
import 'package:flutter_invoice_app/res/component/invoice_text_field.dart';
import 'package:flutter_invoice_app/res/routes/routes.dart';
import 'package:get/get.dart';

class ItemScreen extends StatefulWidget {
  const ItemScreen({Key? key}) : super(key: key);

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  TextEditingController category = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
      return Scaffold(
        appBar: AppBar(
          title: Text("Item"),
          actions: [
            IconButton(
              onPressed: (){
                Get.defaultDialog(
                  title: "Add Category",
                  content: InvoiceTextField(
                    title: "Enter Your Category",
                    controller: category,
                  ),
                  cancel: AppButton(
                    title: "Add",
                    height: size.height * 0.03,
                    width: size.width * 0.3,
                    onTap: (){
                      AppApiService.categori.add({
                        "category" : category.text.trim(),
                      }).then((value){
                        category.clear();
                        Get.back();
                      });
                    },
                  ),
                  confirm: AppButton(
                    title: "Cancel",
                    height: size.height * 0.03,
                    width: size.width * 0.3,
                  ),
                );
              },
              icon: Icon(Icons.category),
            ),
          ],
        ),
        body: StreamBuilder(
          stream: AppApiService.item.snapshots(),
          builder: (context,snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context,index){
                  var items = snapshot.data!.docs[index];
                  return Card(
                    child: ListTile(
                      title: Text(items["itemName"]),
                      trailing: Text("Rs ${items["sale"]}"),
                      onTap: (){
                        Get.toNamed(
                          AppRoutes.itemDetail,
                          arguments: [
                            items["itemName"],
                            items["sale"],
                            items["cost"],
                            items["wholeSale"],
                            items["stock"],
                            items["tax"],
                            items["companyName"],
                            items["categori"],
                            items["saleDate"],
                            items["expiryDate"],
                            snapshot.data!.docs[index].id,
                          ],
                        );
                      },
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
