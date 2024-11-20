import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/component/app_button.dart';
import 'package:flutter_invoice_app/view/bottam%20navigator%20bar/sales/sales_screen.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../res/colors/app_colors.dart';

class AddToCardOrderScreen extends StatefulWidget {
  AddToCardOrderScreen({required this.product, super.key});
  List<Product> product;

  @override
  State<AddToCardOrderScreen> createState() => _AddToCardOrderScreenState();
}

class _AddToCardOrderScreenState extends State<AddToCardOrderScreen> {

  double calculateProductTotal(double itemPrice,double discount,double tax,int stock) {
    // Calculate discounted price
    double discountedPrice = itemPrice - (itemPrice * discount / 100);
    // Add tax to discounted price
    double taxedPrice = discountedPrice + (discountedPrice * tax / 100);
    // Total amount considering stock
    return taxedPrice * stock;
  }

  @override
  Widget build(BuildContext context) {
    // Calculate subtotal, total discount, total tax, and total amount
    double subtotal = widget.product.fold(0, (sum, item) {
      return sum + (item.price * item.stock);
    });

    double totalDiscount = widget.product.fold(0, (sum, item) {
      return sum + ((item.price * item.discount / 100) * item.stock);
    });

    double totalTax = widget.product.fold(0, (sum, item) {
      double discountedPrice = item.price - (item.price * item.discount / 100);
      return sum + ((discountedPrice * item.tax / 100) * item.stock);
    });

    double totalAmount = subtotal - totalDiscount + totalTax;

    return Scaffold(
      appBar: AppBar(
        title: Text("Add to Cart"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: widget.product.isEmpty ?
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.shopping_cart,
                    size: 100,
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      "Your cart is empty",
                      style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 20),
                  AppButton(
                    title: "Back",
                    height: 40,
                    width: 100,
                    onTap: () {
                      Get.back();
                    },
                  ),
                ],
              ) :
              ListView.builder(
                itemCount: widget.product.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                                  widget.product[index].product,
                                  style: GoogleFonts.lato(
                                      fontWeight: FontWeight.w600, fontSize: 16),
                                ),
                                Text(
                                  "Price: ${widget.product[index].price.toStringAsFixed(2)}",
                                  style: GoogleFonts.lato(color: Colors.grey),
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
                                  "Discount: ${widget.product[index].discount.toStringAsFixed(0)}%",
                                  style: GoogleFonts.lato(color: Colors.grey),
                                ),
                                Text(
                                  "Tax: ${widget.product[index].tax.toStringAsFixed(0)}%",
                                  style: GoogleFonts.lato(color: Colors.grey),
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
                                  "Total Amount: ${calculateProductTotal(
                                    widget.product[index].price,
                                    widget.product[index].discount,
                                    widget.product[index].tax,
                                    widget.product[index].stock,
                                  )}",
                                  style: GoogleFonts.lato(color: Colors.grey),),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          widget.product[index].stock++;
                                        });
                                      },
                                      icon: Icon(
                                        CupertinoIcons.plus_circle,
                                        color: Colors.green,
                                      ),
                                    ),
                                    Text(
                                      "${widget.product[index].stock}",
                                      style: GoogleFonts.lato(
                                          color: AppColor.primaryColor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (widget.product[index].stock > 1) {
                                            widget.product[index].stock--;
                                          } else {
                                            widget.product.removeAt(index);
                                          }
                                        });
                                      },
                                      icon: Icon(
                                        Icons.remove_circle_outline,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            widget.product.isEmpty ? SizedBox() : Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Subtotal",
                        style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "Rs. ${subtotal.toStringAsFixed(2)}",
                        style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Amount",
                        style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Rs. ${totalAmount.toStringAsFixed(2)}",
                        style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            widget.product.isEmpty ? SizedBox() : AppButton(
              title: "Save Invoice",
              height: 50,
              width: double.infinity,
              textColor: widget.product.isEmpty ? AppColor.blackColor : AppColor.whiteColor,
              color: widget.product.isEmpty ? AppColor.whiteColor : AppColor.primaryColor,
              onTap: (){

              },
            )
          ],
        ),
      ),
    );
  }
}
