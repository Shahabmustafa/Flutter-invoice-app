import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/model/invoice_model.dart';
import 'package:flutter_invoice_app/res/app_api/app_api_service.dart';
import 'package:flutter_invoice_app/res/routes/routes.dart';
import 'package:flutter_invoice_app/utils/print_utils.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../model/product_model.dart';
import '../../../res/assets/assets_url.dart';
import '../../../res/colors/app_colors.dart';

class SaleInvoiceScreen extends StatefulWidget {
  const SaleInvoiceScreen({super.key});

  @override
  State<SaleInvoiceScreen> createState() => _SaleInvoiceScreenState();
}

class _SaleInvoiceScreenState extends State<SaleInvoiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sale Invoice"),
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder(
        stream: AppApiService.sale.orderBy("date",descending: false).snapshots(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context,index){
                Timestamp timestamp = snapshot.data!.docs[index]['date'];

                DateTime dateTime = timestamp.toDate();
                String formattedDate = DateFormat('dd-MMMM-yyyy').format(dateTime);
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
                                          AppRoutes.saleInvoiceDetailScreen,
                                          arguments: [
                                            snapshot.data!.docs[index]["invoiceId"],
                                            snapshot.data!.docs[index]["productList"],
                                            snapshot.data!.docs[index]["subTotal"],
                                            snapshot.data!.docs[index]["totalAmount"],
                                            snapshot.data!.docs[index].data().containsKey("customer") ? snapshot.data!.docs[index]["customer"].toString() : "Cash Sale",
                                            snapshot.data!.docs[index]["received_amount"],
                                          ]
                                      );
                                    },
                                    icon: AssetsUrl.categoryEditSvgIcon,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      List<Product> productList = (snapshot.data!.docs[index]["productList"] as List)
                                          .map((item) => Product.fromMap(item))
                                          .toList();
                                      SaleInvoicePDFPrint.generateSimpleInvoice(
                                        invoiceId: snapshot.data!.docs[index]["invoiceId"].toString(),
                                        customerName: snapshot.data!.docs[index].data().containsKey("customer") ? snapshot.data!.docs[index]["customer"].toString() : "Cash Sale",
                                        subtotal: snapshot.data!.docs[index]["subTotal"].toString(),
                                        totalAmount: snapshot.data!.docs[index]["totalAmount"].toString(),
                                        recievedAmount: snapshot.data!.docs[index]["received_amount"].toString(),
                                        discount: snapshot.data!.docs[index]["discount"].toString(),
                                        tax: snapshot.data!.docs[index]["tax"].toString(),
                                        date: formattedDate,
                                        product: productList,
                                      );
                                    },
                                    icon: Icon(CupertinoIcons.printer, color: AppColor.errorColor),
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
                              Text("${snapshot.data!.docs[index].data().containsKey("customer") ? snapshot.data!.docs[index]["customer"].toString() : "Cash Sale"}",style: GoogleFonts.lato(color: Colors.black),),
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
          }else{
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.toNamed(AppRoutes.saleScreen);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
