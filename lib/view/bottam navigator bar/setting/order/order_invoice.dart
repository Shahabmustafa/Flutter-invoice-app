import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/routes/routes.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../model/product_model.dart';
import '../../../../res/assets/assets_url.dart';
import '../../../../res/colors/app_colors.dart';
import '../../../../utils/print_utils.dart';
import '../../../../utils/utils.dart';

class OrderInvoiceScreen extends StatefulWidget {
  const OrderInvoiceScreen({Key? key}) : super(key: key);

  @override
  State<OrderInvoiceScreen> createState() => _OrderInvoiceScreenState();
}

class _OrderInvoiceScreenState extends State<OrderInvoiceScreen> {

  var itemData = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Invoice"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("orders").orderBy("date",descending: false).snapshots(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            if(snapshot.data!.docs.isEmpty){
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.cube_box,color: AppColor.primaryColor,size: 100,),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      "Order is Empty",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              );
            }else{
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context,index){
                  Timestamp timestamp = snapshot.data!.docs[index]['date'];
                  DateTime dateTime = timestamp.toDate();
                  String formattedDate = DateFormat('dd-MM-yyyy hh:mm a').format(dateTime);
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    child: Container(
                      height: 220,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: AppColor.whiteColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 0.8,
                            color: Colors.grey,
                            offset: Offset(0.3, 0.2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Invoice No " + snapshot.data!.docs[index]["invoiceId"].toString(),style: GoogleFonts.lato(fontWeight: FontWeight.w600,fontSize: 16,color: AppColor.primaryColor),),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: (){
                                        Get.toNamed(
                                            AppRoutes.orderInvoiceDetailScreen,
                                            arguments: [
                                              snapshot.data!.docs[index]["productList"],
                                              snapshot.data!.docs[index]["discount"],
                                              snapshot.data!.docs[index]["subTotal"],
                                              snapshot.data!.docs[index]["tax"],
                                              snapshot.data!.docs[index]["totalAmount"],
                                              snapshot.data!.docs[index]["invoiceId"],
                                              snapshot.data!.docs[index].data().containsKey("company") ? snapshot.data!.docs[index]["company"].toString() : "",
                                              snapshot.data!.docs[index]["received_amount"],
                                              formattedDate,
                                              snapshot.data!.docs[index]["due_amount"],
                                            ]
                                        );
                                      },
                                      icon: Icon(Icons.visibility_outlined),
                                    ),
                                    IconButton(
                                      onPressed: (){
                                        List<Product> productList = (snapshot.data!.docs[index]["productList"] as List)
                                            .map((item) => Product.fromMap(item))
                                            .toList();
                                        SaleInvoicePDFPrint.generateSimpleInvoice(
                                          invoiceId: snapshot.data!.docs[index]["invoiceId"].toString(),
                                          customerName: snapshot.data!.docs[index]["company"].toString(),
                                          subtotal: snapshot.data!.docs[index]["subTotal"].toString(),
                                          totalAmount: snapshot.data!.docs[index]["totalAmount"].toString(),
                                          recievedAmount: snapshot.data!.docs[index]["received_amount"].toString(),
                                          discount: snapshot.data!.docs[index]["discount"].toString(),
                                          tax: snapshot.data!.docs[index]["tax"].toString(),
                                          date: formattedDate,
                                          product: productList,
                                        );
                                      },
                                      icon: Icon(CupertinoIcons.printer,color: AppColor.errorColor,),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  formattedDate,
                                  style: GoogleFonts.lato(color: AppColor.blackColor),
                                ),
                                Text("${snapshot.data!.docs[index].data().containsKey("company") ? snapshot.data!.docs[index]["company"].toString() : ""}",style: GoogleFonts.lato(color: Colors.black),),
                              ],
                            ),
                          ),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Sub Total ${snapshot.data!.docs[index]["subTotal"].toString()}",style: GoogleFonts.lato(color: AppColor.blackColor),),
                                Text("Total Amount " + snapshot.data!.docs[index]["totalAmount"].toString(),style: GoogleFonts.lato(color: Colors.black),),
                              ],
                            ),
                          ),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Tax ${snapshot.data!.docs[index]["tax"].toString()}",style: GoogleFonts.lato(color: Colors.black),),
                                Text("Discount ${snapshot.data!.docs[index]["discount"].toString()}",style: GoogleFonts.lato(color: Colors.black),),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          }else{
            return Center(child: Utils.circular);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.toNamed(AppRoutes.orderScreen);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
