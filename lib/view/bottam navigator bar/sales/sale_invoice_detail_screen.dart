import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../res/colors/app_colors.dart';

class SaleInvoiceDetailScreen extends StatefulWidget {
  const SaleInvoiceDetailScreen({super.key});

  @override
  State<SaleInvoiceDetailScreen> createState() => _SaleInvoiceDetailScreenState();
}

class _SaleInvoiceDetailScreenState extends State<SaleInvoiceDetailScreen> {
  var customerData = Get.arguments;

  @override
  Widget build(BuildContext context) {
    final productList = customerData[0];
    final discount = customerData[1];
    final subTotal = customerData[2];
    final tax = customerData[3];
    final totalAmount = customerData[4];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sale Invoice Detail"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: productList.length, // Correct length of productList
              itemBuilder: (context, index) {
                var product = productList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                              Text(
                                product["product"],
                                style: GoogleFonts.lato(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: AppColor.primaryColor,
                                ),
                              ),
                              Text(
                                "Price: ${product["price"].toStringAsFixed(2)}",
                                style: GoogleFonts.lato(color: Colors.black),
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
                                "Discount: ${product["discount"].toStringAsFixed(0)}%",
                                style: GoogleFonts.lato(color: Colors.black),
                              ),
                              Text(
                                "Tax: ${product["tax"]}%",
                                style: GoogleFonts.lato(color: Colors.black),
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
                                "Stock: ${product["stock"]}",
                                style: GoogleFonts.lato(color: Colors.black),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Tax",
                      style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Rs. ${tax}",
                      style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Discount",
                      style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Rs. ${discount}",
                      style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Subtotal",
                      style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Rs. ${subTotal}",
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
                      style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Rs. ${totalAmount}",
                      style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
