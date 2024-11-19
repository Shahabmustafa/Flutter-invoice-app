import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/routes/routes.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../res/app_api/app_api_service.dart';
import '../../../../res/assets/assets_url.dart';
import '../../../../res/colors/app_colors.dart';

class SupplierScreen extends StatefulWidget {
  const SupplierScreen({Key? key}) : super(key: key);

  @override
  State<SupplierScreen> createState() => _SupplierScreenState();
}

class _SupplierScreenState extends State<SupplierScreen> {

  bool search = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: search ?
        TextField(
          cursorHeight: 18,
          cursorColor: AppColor.whiteColor,
          style: GoogleFonts.lato(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColor.whiteColor,
          ),
          decoration: InputDecoration(
              hintText: "Supplier Name",
              hintStyle: GoogleFonts.lato(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColor.whiteColor,
              ),
              border: InputBorder.none
          ),
        ) :
        Text("Supplier"),
        actions: [
          IconButton(
            onPressed: (){
              if(search == false){
                search = true;
                setState(() {

                });
              }else{
                search = false;
                setState(() {

                });
              }
            },
            icon: Icon(CupertinoIcons.search),
          )
        ],
      ),
      body: StreamBuilder(
        stream: AppApiService.supplier.snapshots(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context,index){
                var supplier = snapshot.data!.docs[index];
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
                              Text(supplier["companyName"],style: GoogleFonts.lato(fontWeight: FontWeight.w600,fontSize: 16),),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: (){
                                      Get.toNamed(
                                        AppRoutes.SupplierDetails,
                                        arguments: [
                                          supplier["companyName"],
                                          supplier["companyEmail"],
                                          supplier["phoneNumber"],
                                          supplier["address"],
                                          supplier["supplierName"],
                                          supplier["supplierPhoneNumber"],
                                          supplier["supplierEmail"],
                                          supplier["payment"],
                                          snapshot.data!.docs[index].id,
                                        ],
                                      );
                                    },
                                    icon: AssetsUrl.categoryEditSvgIcon,
                                  ),
                                  IconButton(
                                    onPressed: (){
                                      AppApiService.item.doc(supplier.id).delete();
                                    },
                                    icon: Icon(CupertinoIcons.delete,size: 22,color: AppColor.errorColor,),
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
                              Text("Company Name",style: GoogleFonts.lato(color: Colors.grey),),
                              Text(supplier["companyName"],style: GoogleFonts.lato(color: AppColor.primaryColor,fontWeight: FontWeight.w600),),
                            ],
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Payment",style: GoogleFonts.lato(color: Colors.grey),),
                              Text(supplier["payment"].toString(),style: GoogleFonts.lato(color: AppColor.primaryColor,fontWeight: FontWeight.w600),),
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
          Get.toNamed(AppRoutes.addSupplier);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
