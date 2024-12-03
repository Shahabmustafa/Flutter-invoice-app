import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/routes/routes.dart';
import 'package:flutter_invoice_app/view%20model/swith_service/swith_service.dart';
import 'package:flutter_invoice_app/view/bottam%20navigator%20bar/setting/installment/specific_customer_installment_screen.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../res/app_api/app_api_service.dart';
import '../../../../res/assets/assets_url.dart';
import '../../../../res/colors/app_colors.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({Key? key}) : super(key: key);

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
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
            hintText: "Customer Name",
            hintStyle: GoogleFonts.lato(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColor.whiteColor,
            ),
            border: InputBorder.none,
          ),
        ) :
        Text("Customer"),
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
        stream: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("customer").snapshots(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            if(snapshot.data!.docs.isEmpty){
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.group,color: AppColor.primaryColor,size: 100,),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      "Customer is Empty",
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
                  var customer = snapshot.data!.docs[index];
                  return GestureDetector(
                    onTap: (){
                      Get.toNamed(
                        AppRoutes.CustomersDetail,
                        arguments: [
                          customer["customerName"],
                          customer["email"],
                          customer["phoneNumber"],
                          customer["address"],
                          customer["payment"],
                          customer["cnic"],
                          customer["category"],
                          snapshot.data!.docs[index].id,
                        ],
                      );
                    },
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 7.5),
                        child: GetBuilder<ThemeController>(
                          builder: (controller){
                            return Container(
                              height: 60,
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                color: controller.isDark ? AppColor.blackColor : AppColor.whiteColor,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: controller.isDark ? AppColor.primaryColor : AppColor.whiteColor,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 0.8,
                                    color: Colors.grey,
                                    offset: Offset(0.3, 0.2),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(customer["customerName"],style: GoogleFonts.lato(color: controller.isDark ? AppColor.whiteColor : AppColor.blackColor,fontWeight: FontWeight.w600,fontSize: 16),),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => SpecificCustomerInstallmentScreen(customerID: snapshot.data!.docs[index]["customerId"],customerName: snapshot.data!.docs[index]["customerName"],)));
                                        },
                                        icon: Icon(CupertinoIcons.clock),
                                      ),
                                      IconButton(
                                        onPressed: (){
                                          FirebaseFirestore.instance.collection("users")
                                              .doc(FirebaseAuth.instance.currentUser!.uid)
                                              .collection("items").doc(snapshot.data!.docs[index].id).delete();
                                        },
                                        icon: Icon(CupertinoIcons.delete,size: 22,color: AppColor.errorColor,),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                    ),
                  );
                },
              );
            }
          }else{
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.toNamed(AppRoutes.addCustomer);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
