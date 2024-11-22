import 'package:badges/badges.dart' as badges;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/app_api/app_api_service.dart';
import 'package:flutter_invoice_app/res/colors/app_colors.dart';
import 'package:flutter_invoice_app/res/component/app_button.dart';
import 'package:flutter_invoice_app/utils/utils.dart';
import 'package:flutter_invoice_app/view/bottam%20navigator%20bar/sales/add_to_card.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../model/product_model.dart';

class SalesPage extends StatefulWidget {
  const SalesPage({Key? key}) : super(key: key);

  @override
  State<SalesPage> createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  List<Product> addProduct = [];
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
                    MaterialPageRoute(builder: (context) => AddToCardScreen(product: addProduct)),
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
        stream: AppApiService.item.snapshots(),
        builder: (context,snapshot){
          if(snapshot.hasData){
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
                              Text("Sale Price ${snapshot.data!.docs[index]["salePrice"]}",style: GoogleFonts.lato(color: Colors.black),),
                              AppButton(
                                title: "Add",
                                height: 30,
                                width: 80,
                                onTap: () {
                                  if (snapshot.data!.docs[index]["stock"] > 0) {
                                    Product product = Product(
                                      productId: snapshot.data!.docs[index]["itemId"],
                                      product: snapshot.data!.docs[index]["itemName"],
                                      price: (snapshot.data!.docs[index]["salePrice"] as num).toDouble(),
                                      stock: 1,
                                      tax: (snapshot.data!.docs[index]["tax"] as num).toDouble(),
                                      discount: (snapshot.data!.docs[index]["discount"] as num).toDouble(),
                                    );
                                    setState(() {
                                      // Check if the product already exists in the cart
                                      int existingIndex = addProduct.indexWhere((p) => p.product == product.product);
                                      if (existingIndex == -1) {
                                        // Add new product to cart
                                        addProduct.add(product);
                                      } else {
                                        // Increment stock by 1 if product already exists in the cart
                                        addProduct[existingIndex].stock += 1;
                                      }
                                      cartCount = addProduct.length;
                                    });

                                  }else{
                                    Utils.flutterToast("Stock Not Available");
                                  }
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
          }else{
            return Center(child: CircularProgressIndicator());
          }
        },
      )
    );
  }
}

