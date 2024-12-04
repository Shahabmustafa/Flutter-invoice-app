import 'package:badges/badges.dart' as badges;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/model/product_model.dart';
import 'package:flutter_invoice_app/res/colors/app_colors.dart';
import 'package:flutter_invoice_app/res/component/app_button.dart';
import 'package:google_fonts/google_fonts.dart';

import 'add_to_card_order_screen.dart';


class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<Product> orderAddProduct = [];
  int cartCount = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Product"),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: badges.Badge(
                position: badges.BadgePosition.topEnd(top: 0, end: 5),
                badgeContent: Text(
                  cartCount.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddToCardOrderScreen(orderProduct: orderAddProduct)),
                    );
                  },
                  icon: Icon(
                    CupertinoIcons.shopping_cart,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("items").snapshots(),
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
                        "Item is Empty",
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
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                      child: Container(
                        height: 140,
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
                                  Text("Barcode",style: GoogleFonts.lato(fontWeight: FontWeight.w600,fontSize: 16),),
                                  Text(snapshot.data!.docs[index]["barcode"],style: GoogleFonts.lato(fontWeight: FontWeight.w600,fontSize: 16),),
                                ],
                              ),
                            ),
                            Divider(),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(snapshot.data!.docs[index]["itemName"],style: GoogleFonts.lato(color: Colors.black),),
                                  Text("Stock ${snapshot.data!.docs[index]["stock"]}",style: GoogleFonts.lato(color: AppColor.blackColor),),
                                ],
                              ),
                            ),
                            Divider(),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Purchase Price ${snapshot.data!.docs[index]["purchasePrice"]}",style: GoogleFonts.lato(color: Colors.black),),
                                  AppButton(
                                    title: "Add",
                                    height: 30,
                                    width: 80,
                                    onTap: () {
                                      Product product = Product(
                                        productId: snapshot.data!.docs[index]["itemId"],
                                        product: snapshot.data!.docs[index]["itemName"],
                                        price: (snapshot.data!.docs[index]["purchasePrice"] as num).toDouble(),
                                        stock: 1,
                                        tax: (snapshot.data!.docs[index]["tax"] as num).toDouble(),
                                        discount: (snapshot.data!.docs[index]["discount"] as num).toDouble(),
                                      );
                                      setState(() {
                                        // Check if the product already exists in the cart
                                        int existingIndex = orderAddProduct.indexWhere((p) => p.product == product.product);
                                        if (existingIndex == -1) {
                                          // Add new product to cart
                                          orderAddProduct.add(product);
                                        } else {
                                          // Increment stock by 1 if product already exists in the cart
                                          orderAddProduct[existingIndex].stock += 1;
                                        }
                                        cartCount = orderAddProduct.length;
                                      });
                                    },
                                  ),
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
              return Center(child: CircularProgressIndicator());
            }
          },
        )
    );
  }
}
