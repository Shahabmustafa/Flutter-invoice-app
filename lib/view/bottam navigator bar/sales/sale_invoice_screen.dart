import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/app_api/app_api_service.dart';
import 'package:flutter_invoice_app/res/routes/routes.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
        stream: AppApiService.sale.snapshots(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context,index){
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  child: Container(
                    height: 160,
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
                              Text("Inv " + snapshot.data!.docs[index]["invoiceId"],style: GoogleFonts.lato(fontWeight: FontWeight.w600,fontSize: 16,color: AppColor.primaryColor),),
                              IconButton(
                                onPressed: (){
                                  Get.toNamed(
                                    AppRoutes.saleInvoiceDetailScreen,
                                    arguments: [
                                      snapshot.data!.docs[index]["productList"],
                                      snapshot.data!.docs[index]["discount"],
                                      snapshot.data!.docs[index]["subTotal"],
                                      snapshot.data!.docs[index]["tax"],
                                      snapshot.data!.docs[index]["totalAmount"],
                                    ]
                                  );
                                },
                                icon: AssetsUrl.categoryEditSvgIcon,
                              )
                            ],
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Sub Total ${snapshot.data!.docs[index]["subTotal"]}",style: GoogleFonts.lato(color: AppColor.grayColor,fontWeight: FontWeight.w600),),
                              Text("Total Amount " + snapshot.data!.docs[index]["totalAmount"],style: GoogleFonts.lato(color: Colors.grey),),
                            ],
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Tax ${snapshot.data!.docs[index]["tax"]}",style: GoogleFonts.lato(color: Colors.grey),),
                              Text("Discount ${snapshot.data!.docs[index]["discount"]}",style: GoogleFonts.lato(color: Colors.grey),),
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
