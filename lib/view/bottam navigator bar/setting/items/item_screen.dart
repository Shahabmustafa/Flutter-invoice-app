import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/routes/routes.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../res/assets/assets_url.dart';
import '../../../../res/colors/app_colors.dart';
import '../../../../utils/utils.dart';

class ItemScreen extends StatefulWidget {
  const ItemScreen({Key? key}) : super(key: key);

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  TextEditingController category = TextEditingController();
  final _key = GlobalKey<FormState>();
  bool search = false;
  TextEditingController searchController = TextEditingController();
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
            controller: searchController,
            style: GoogleFonts.lato(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColor.whiteColor,
            ),
            decoration: InputDecoration(
                hintText: "Items Name",
                hintStyle: GoogleFonts.lato(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColor.whiteColor,
                ),
                border: InputBorder.none
            ),
            onChanged: (value){
              setState(() {
                searchQuery = value.toLowerCase();
              });
            },
          ) :
          Text("Items"),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  search = !search;
                  if (!search) {
                    searchQuery = "";
                    searchController.clear();
                  }
                });
              },
              icon: Icon(CupertinoIcons.search),
            )
          ],
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("items").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final allItems = snapshot.data!.docs;
              final filteredItems = searchQuery.isEmpty ? allItems : allItems.where((item) {
                final itemName = item["itemName"].toString().toLowerCase();
                return itemName.contains(searchQuery);
              }).toList();
              if (filteredItems.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(CupertinoIcons.cube_box,
                          color: AppColor.primaryColor, size: 100),
                      SizedBox(height: 20),
                      Text(
                        "No items found",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  final item = filteredItems[index];
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(
                        AppRoutes.itemDetail,
                        arguments: [
                          item["category"],
                          item["companyName"],
                          item["expiryDate"],
                          item["itemName"],
                          item["purchasePrice"].toString(),
                          item["saleDate"],
                          item["salePrice"].toString(),
                          item["stock"].toString(),
                          item["tax"].toString(),
                          item["discount"].toString(),
                          item["barcode"],
                          item.id,
                        ],
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
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
                                  Text(
                                    item["barcode"],
                                    style: GoogleFonts.lato(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Get.toNamed(
                                            AppRoutes.editItem,
                                            arguments: [
                                              item["itemId"],
                                              item["barcode"],
                                              item["itemName"],
                                              item["salePrice"].toString(),
                                              item["purchasePrice"].toString(),
                                              item["discount"].toString(),
                                              item["tax"].toString(),
                                            ],
                                          );
                                        },
                                        icon: AssetsUrl.categoryEditSvgIcon,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          FirebaseFirestore.instance
                                              .collection("users")
                                              .doc(FirebaseAuth
                                              .instance.currentUser!.uid)
                                              .collection("items")
                                              .doc(item.id)
                                              .delete();
                                        },
                                        icon: Icon(
                                          CupertinoIcons.delete,
                                          size: 22,
                                          color: AppColor.errorColor,
                                        ),
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
                                  Text("Product Name",
                                      style: GoogleFonts.lato(color: Colors.grey)),
                                  Text(
                                    item["itemName"],
                                    style: GoogleFonts.lato(
                                        color: AppColor.primaryColor,
                                        fontWeight: FontWeight.w600),
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
                                  Text("Price",
                                      style: GoogleFonts.lato(color: Colors.grey)),
                                  Text(
                                    item["salePrice"].toString(),
                                    style: GoogleFonts.lato(
                                        color: AppColor.primaryColor,
                                        fontWeight: FontWeight.w600),
                                  ),
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
            } else {
              return Center(child: Utils.circular);
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
