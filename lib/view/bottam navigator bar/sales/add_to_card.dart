import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/component/app_button.dart';
import 'package:flutter_invoice_app/view/bottam%20navigator%20bar/sales/sales_screen.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddToCardScreen extends StatefulWidget {
  AddToCardScreen({required this.product, super.key});
  List<Product> product;

  @override
  State<AddToCardScreen> createState() => _AddToCardScreenState();
}

class _AddToCardScreenState extends State<AddToCardScreen> {
  @override
  Widget build(BuildContext context) {
    double totalAmount = widget.product.fold(0, (sum, item) {
      return sum + (item.price * item.stock);
    });

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
                  Icon(CupertinoIcons.shopping_cart,size: 100,),
                  SizedBox(height: 20,),
                  Center(child: Text("your product not add",style: GoogleFonts.lato(fontSize: 20,fontWeight: FontWeight.bold),)),
                  SizedBox(height: 20,),
                  AppButton(
                    title: "Back",
                    height: 40,
                    width: 100,
                    onTap: (){
                      Get.back();
                    },
                  )
                ],
              ) :
              ListView.builder(
                itemCount: widget.product.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.only(bottom: 16),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Product Details
                          Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    "${index + 1}",
                                    style: GoogleFonts.lato(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.product[index].product,
                                    style: GoogleFonts.lato(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "Stock: ${widget.product[index].stock}",
                                    style: GoogleFonts.lato(
                                      color: Colors.grey[600],
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          // Price and Quantity Controls
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              // Price per item * Quantity
                              Text(
                                "Rs. ${(widget.product[index].price * widget.product[index].stock).toStringAsFixed(2)}",
                                style: GoogleFonts.lato(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        widget.product[index].stock++;
                                        totalAmount = widget.product.fold(0, (sum, item) {
                                          return sum + (item.price * item.stock);
                                        });
                                      });
                                    },
                                    icon: Icon(CupertinoIcons.plus_circle, color: Colors.green),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        // Decrease the quantity (stock) by 1 if it's greater than 1
                                        if (widget.product[index].stock > 1) {
                                          widget.product[index].stock--;
                                        } else {
                                          // If the stock is 1, remove the product from the list
                                          widget.product.removeAt(index);
                                        }

                                        // Recalculate the total amount
                                        totalAmount = widget.product.fold(0, (sum, item) {
                                          return sum + (item.price * item.stock);
                                        });
                                      });
                                    },
                                    icon: Icon(Icons.remove_circle_outline, color: Colors.red),
                                  )

                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            // Subtotal and Total
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "SubTotal",
                    style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Rs. ${totalAmount.toStringAsFixed(2)}",
                    style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Amount",
                  style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Text(
                  "Rs. ${totalAmount.toStringAsFixed(2)}",
                  style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
