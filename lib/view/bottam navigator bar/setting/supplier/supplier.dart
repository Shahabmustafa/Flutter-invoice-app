import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/routes/routes.dart';
import 'package:flutter_invoice_app/view/bottam%20navigator%20bar/setting/installment/specific_supplier_installment_screen.dart';
import 'package:flutter_invoice_app/view/bottam%20navigator%20bar/setting/installment/supplier_installment_screen.dart';
import 'package:flutter_invoice_app/view/bottam%20navigator%20bar/setting/supplier/supplier_specific_order_invoice_screen.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../res/colors/app_colors.dart';
import '../../../../utils/utils.dart';

class SupplierScreen extends StatefulWidget {
  const SupplierScreen({Key? key}) : super(key: key);

  @override
  State<SupplierScreen> createState() => _SupplierScreenState();
}

class _SupplierScreenState extends State<SupplierScreen> {

  bool search = false;
  String searchQuery = "";


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: search ? TextField(
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
          onChanged: (value) {
            setState(() {
              searchQuery = value.trim();
            });
          },
        ) : Text("Supplier"),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                search = !search;
                if (!search) searchQuery = "";
              });
            },
            icon: Icon(CupertinoIcons.search),
          )
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("supplier").snapshots(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            var supplier = snapshot.data!.docs;
            if (searchQuery.isNotEmpty) {
              supplier = supplier.where((customer) {
                String name = customer["supplierName"] ?? "";
                return name.toLowerCase().contains(searchQuery.toLowerCase());
              }).toList();
            }
            if(supplier.isEmpty){
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.building_2_fill,color: AppColor.primaryColor,size: 100,),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      "Supplier Not Found",
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
                  var supplier = snapshot.data!.docs[index];
                  return GestureDetector(
                    onTap: (){
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
                          supplier["payment"].toString(),
                          snapshot.data!.docs[index].id,
                        ],
                      );
                    },
                    child: Padding(
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
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => SpecificSupplierInstallmentScreen(supplierID: snapshot.data!.docs[index]["supplierId"],supplierName: snapshot.data!.docs[index]["supplierName"],)));
                                        },
                                        icon: Icon(CupertinoIcons.clock,color: AppColor.primaryColor,),
                                      ),
                                      IconButton(
                                        onPressed: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => SupplierSpecificOrderScreen(supplierID: snapshot.data!.docs[index]["supplierId"],)));
                                        },
                                        icon: Icon(CupertinoIcons.cube_box,size: 22,color: AppColor.primaryColor,),
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
          Get.toNamed(AppRoutes.addSupplier);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
