import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_invoice_app/res/component/app_button.dart';
import 'package:flutter_invoice_app/res/component/invoice_text_field.dart';
import 'package:flutter_invoice_app/utils/utils.dart';
import 'package:flutter_invoice_app/view%20model/firebase/saleinvoice_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../model/product_model.dart';
import '../../../res/colors/app_colors.dart';

class AddToCardScreen extends StatefulWidget {
  AddToCardScreen({required this.product, super.key});
  List<Product> product;

  @override
  State<AddToCardScreen> createState() => _AddToCardScreenState();
}

class _AddToCardScreenState extends State<AddToCardScreen> {

  final invoice = Get.put(SaleInvoiceController());

  double calculateProductTotal(double itemPrice,double discount,double tax,int stock) {
    // Calculate discounted price
    double discountedPrice = itemPrice - (itemPrice * discount / 100);
    // Add tax to discounted price
    double taxedPrice = discountedPrice + (discountedPrice * tax / 100);
    // Total amount considering stock
    return taxedPrice * stock;
  }

  subtractTwoValue(int receivedAmount,var totalAmount) {
    return totalAmount - receivedAmount;
  }


  @override
  Widget build(BuildContext context) {
    double subtotal = widget.product.fold(0, (sum, item) {
      return sum + (item.salePrice * item.stock);
    });

    double totalDiscount = widget.product.fold(0, (sum, item) {
      return sum + ((item.salePrice * item.discount / 100) * item.stock);
    });

    double totalTax = widget.product.fold(0, (sum, item) {
      double discountedPrice = item.salePrice - (item.salePrice * item.discount / 100);
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
                                  "Price: ${widget.product[index].purchasePrice.toStringAsFixed(2)}",
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
                                    widget.product[index].salePrice,
                                    widget.product[index].discount,
                                    widget.product[index].tax,
                                    widget.product[index].stock,
                                  )}",
                                  style: GoogleFonts.lato(color: Colors.grey),
                                ),
                                CountTextField(
                                  orderProduct: widget.product,
                                  index: index,
                                  onStockChanged: () {
                                    setState(() {
                                    });
                                  },
                                )
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
            widget.product.isEmpty ? SizedBox() :
            Padding(
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
            widget.product.isEmpty ?
            SizedBox() :
            AppButton(
              title: "Save Invoice",
              height: 50,
              width: double.infinity,
              textColor: widget.product.isEmpty ? AppColor.blackColor : AppColor.whiteColor,
              color: widget.product.isEmpty ? AppColor.whiteColor : AppColor.primaryColor,
              onTap: (){
                showDialog(
                  context: context,
                  builder: (context){
                    return StatefulBuilder(
                      builder: (context,setState){
                        return AlertDialog(
                          title: Text("Summary"),
                          content: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                DropdownSearch<String>(
                                  items: (f, cs) => invoice.dropdownCustomer,
                                  dropdownBuilder: (context, selectedItem) {
                                    if (selectedItem == null) {
                                      return Text("Please Select Customer");
                                    }
                                    return Text(selectedItem);
                                  },
                                  popupProps: PopupProps.menu(
                                    showSearchBox: true,
                                    showSelectedItems: true,
                                    itemBuilder: (ctx, item, isDisabled, isSelected) {
                                      return ListTile(
                                        title: Text(item),
                                      );
                                    },
                                    constraints: BoxConstraints(
                                      maxHeight: (invoice.dropdownCustomer.value.length > 5) ? 300.0 : 150.0,
                                    ),
                                  ),
                                  onChanged: (value) {
                                    if (invoice.dropdownCustomer.isNotEmpty && invoice.dropdownCustomerIds.isNotEmpty) {
                                      int index = invoice.dropdownCustomer.indexOf(value!);

                                      // Check if index is valid before accessing dropdownCustomerIds
                                      if (index >= 0 && index < invoice.dropdownCustomerIds.length) {
                                        String selectedCustomerId = invoice.dropdownCustomerIds[index];
                                        String selectedCustomerName = invoice.dropdownCustomer[index];
                                        print("Selected Customer ID: $selectedCustomerId");
                                        print("Selected Customer Name: $selectedCustomerName");
                                        invoice.selectCustomerId.value = selectedCustomerId;
                                        invoice.selectCustomer.value = selectedCustomerName;
                                      } else {
                                        print("Invalid index or empty lists");
                                      }
                                    } else {
                                      print("Customer data is not loaded or empty");
                                    }
                                  },
                                ),
                                SizedBox(height: 10,),
                                InvoiceTextField(
                                  title: "Total Amount",
                                  enabled: false,
                                  controller: TextEditingController(text: totalAmount.toString()),
                                ),
                                SizedBox(height: 10,),
                                InvoiceTextField(
                                  title: "Received Amount",
                                  controller: invoice.payAmount,
                                  onlyNumber: true,
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            AppButton(
                              title: "Cancel",
                              height: 40,
                              width: 120,
                              color: AppColor.whiteColor,
                              textColor: AppColor.primaryColor,
                              onTap: (){
                                Get.back();
                              },
                            ),
                            Obx((){
                              return AppButton(
                                title: "Save",
                                height: 40,
                                width: 120,
                                color: AppColor.primaryColor,
                                textColor: AppColor.whiteColor,
                                loading: invoice.loading.value,
                                onTap: (){
                                  if(totalAmount < int.parse(invoice.payAmount.text)){
                                    Utils.flutterToast("your amount is received is greater than to total amount");
                                  }else{
                                    invoice.addSaleInvoice(
                                      widget.product,
                                      subtotal.toInt(),
                                      totalAmount.toInt(),
                                      totalTax.toInt(),
                                      totalDiscount.toInt(),
                                    );
                                  }
                                },
                              );
                            }),
                          ],
                        );
                      },
                    );
                  },
                );

              },
            ),
          ],
        ),
      ),
    );
  }
}


class CountTextField extends StatefulWidget {
  CountTextField({
    required this.orderProduct,
    required this.index,
    required this.onStockChanged,
    super.key,
  });

  final List orderProduct;
  final int index;
  final VoidCallback onStockChanged;

  @override
  State<CountTextField> createState() => _CountTextFieldState();
}

class _CountTextFieldState extends State<CountTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.orderProduct[widget.index].stock.toString(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      child: TextField(
        controller: _controller,
        keyboardType: TextInputType.number,
        cursorColor: AppColor.primaryColor,
        cursorHeight: 18,
        onChanged: (value) {
          if (int.tryParse(value) != null) {
            setState(() {
              widget.orderProduct[widget.index].stock = int.parse(value);
            });
            widget.onStockChanged();
          }
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          labelText: "Stock",
        ),
        style: GoogleFonts.lato(
          color: AppColor.primaryColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
