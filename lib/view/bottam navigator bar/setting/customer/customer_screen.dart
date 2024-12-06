import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/routes/routes.dart';
import 'package:flutter_invoice_app/view/bottam%20navigator%20bar/setting/installment/specific_customer_installment_screen.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../res/colors/app_colors.dart';
import '../../../../utils/utils.dart';
import 'customer_specific_invoice_list_screen.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({Key? key}) : super(key: key);

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  bool search = false;
  String searchQuery = "";

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
            hintText: "Search Customer",
            hintStyle: GoogleFonts.lato(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColor.whiteColor,
            ),
            border: InputBorder.none,
          ),
          onChanged: (value) {
            setState(() {
              searchQuery = value.trim();
            });
          },
        ) :
        Text("Customer"),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                search = !search;
                if (!search) searchQuery = ""; // Reset search query
              });
            },
            icon: Icon(CupertinoIcons.search),
          )
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("customer").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var customers = snapshot.data!.docs;
            // Apply search filter
            if (searchQuery.isNotEmpty) {
              customers = customers.where((customer) {
                String name = customer["customerName"] ?? "";
                return name.toLowerCase().contains(searchQuery.toLowerCase());
              }).toList();
            }

            if (customers.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(CupertinoIcons.group, color: AppColor.primaryColor, size: 100),
                    SizedBox(height: 20),
                    Text(
                      "No customers found",
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                    ),
                  ],
                ),
              );
            } else {
              return ListView.builder(
                itemCount: customers.length,
                itemBuilder: (context, index) {
                  var customer = customers[index];
                  return GestureDetector(
                    onTap: () {
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
                          customer.id,
                        ],
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
                      child: Container(
                        height: 60,
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              customer["customerName"],
                              style: GoogleFonts.lato(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => SpecificCustomerInstallmentScreen(customerID: snapshot.data!.docs[index]["customerId"],customerName: snapshot.data!.docs[index]["customerName"],)));
                                  },
                                  icon: Icon(CupertinoIcons.clock,color: AppColor.primaryColor,),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => CustomerSpecificSaleInvoiceScreen(customerID: snapshot.data!.docs[index]["customerId"])));
                                  },
                                  icon: Icon(
                                    CupertinoIcons.shopping_cart,
                                    size: 22,
                                    color: AppColor.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          } else {
            return Center(child: Utils.circular);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoutes.addCustomer);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
