import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/model/item_model.dart';
import 'package:flutter_invoice_app/res/colors/app_colors.dart';
import 'package:flutter_invoice_app/res/routes/routes.dart';
import 'package:get/get.dart';
import '../../../../res/app_api/app_api_service.dart';
import '../../../../view model/pdf_service/pdf_invice_service.dart';

class ItemList extends StatefulWidget {
  const ItemList({Key? key}) : super(key: key);

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("List of Item"),
      ),
      body: StreamBuilder(
        stream: AppApiService.firestore
            .collection("users")
            .doc(AppApiService.userId)
            .collection("items")
            .snapshots(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context,index){
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    height: size.height * 0.5,
                    width: size.width * 1,
                    decoration: BoxDecoration(
                      color: AppColor.whiteColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            blurRadius: 0.3,
                            spreadRadius: 0.1,
                            offset: Offset(0.1,1)
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: ()async{
                                ItemModel itemModel = ItemModel(
                                  customerName: snapshot.data!.docs[index]["customerName"],
                                  customerEmail: snapshot.data!.docs[index]["customerEmail"],
                                  customerPhone: snapshot.data!.docs[index]["customerPhone"],
                                  customerAddress: snapshot.data!.docs[index]["customerAddress"],
                                  itemName: snapshot.data!.docs[index]["itemName"],
                                  itemCost: snapshot.data!.docs[index]["itemCost"],
                                  discount: snapshot.data!.docs[index]["discount"],
                                  tax: snapshot.data!.docs[index]["tax"],
                                  total: snapshot.data!.docs[index]["total"],
                                  paid: snapshot.data!.docs[index]["paid"],
                                  totalDept: snapshot.data!.docs[index]["totalDept"],
                                );
                                final pdfFile = await PdfInvoiceService.generate(itemModel);
                                PdfApi.openFile(pdfFile);
                              },
                              child: Icon(
                                Icons.print,
                                color: AppColor.primaryColor,
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                AppApiService.firestore
                                    .collection("users")
                                    .doc(AppApiService.userId)
                                    .collection("items")
                                    .doc(snapshot.data!.docs[index].id)
                                    .delete();
                              },
                              child: Icon(
                                Icons.delete,
                                color: AppColor.errorColor,
                              ),
                            ),
                            Icon(Icons.edit,color: AppColor.primaryColor,),
                          ],
                        ),
                        TextWidgets(
                          title: "Customer Name",
                          subtitle: snapshot.data!.docs[index]["customerName"],
                        ),
                        TextWidgets(
                          title: "C-Email",
                          subtitle: snapshot.data!.docs[index]["customerEmail"],
                        ),
                        TextWidgets(
                          title: "Phone Number",
                          subtitle: snapshot.data!.docs[index]["customerPhone"],
                        ),
                        TextWidgets(
                          title: "Address",
                          subtitle: snapshot.data!.docs[index]["customerAddress"],
                        ),
                        TextWidgets(
                          title: "Item Name",
                          subtitle: snapshot.data!.docs[index]["itemName"],
                        ),
                        TextWidgets(
                          title: "Item Price",
                          subtitle: snapshot.data!.docs[index]["itemCost"],
                        ),
                        TextWidgets(
                          title: "Discount",
                          subtitle: "${snapshot.data!.docs[index]["discount"]}%",
                        ),
                        TextWidgets(
                          title: "Tax",
                          subtitle: "${snapshot.data!.docs[index]["tax"]}%",
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Divider(
                            color: AppColor.primaryColor,
                          ),
                        ),
                        TextWidgets(
                          title: "Total",
                          subtitle: snapshot.data!.docs[index]["total"],
                        ),
                        TextWidgets(
                          title: "Paid",
                          subtitle: snapshot.data!.docs[index]["paid"],
                        ),
                        TextWidgets(
                          title: "Total Debt",
                          subtitle: snapshot.data!.docs[index]["totalDept"],
                        ),
                      ],
                    ),
                  ),
                );
                },
            );
          }else{
            return CircularProgressIndicator();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.toNamed(AppRoutes.addItem);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}


class TextWidgets extends StatelessWidget {
  TextWidgets({Key? key,required this.title,required this.subtitle}) : super(key: key);
  String title;
  String subtitle;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
        subtitle,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

