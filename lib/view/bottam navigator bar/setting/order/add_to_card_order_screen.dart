import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_invoice_app/res/component/app_button.dart';
import 'package:flutter_invoice_app/view%20model/firebase/order_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../model/product_model.dart';
import '../../../../res/colors/app_colors.dart';
import '../../../../res/component/invoice_text_field.dart';
import '../../../../utils/utils.dart';

class AddToCardOrderScreen extends StatefulWidget {
  AddToCardOrderScreen({required this.orderProduct, super.key});
  List<Product> orderProduct;

  @override
  State<AddToCardOrderScreen> createState() => _AddToCardOrderScreenState();
}

class _AddToCardOrderScreenState extends State<AddToCardOrderScreen> {

  final invoice = Get.put(OrderController());

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
    double subtotal = widget.orderProduct.fold(0, (sum, item) {
      return sum + (item.purchasePrice * item.stock);
    });

    double totalDiscount = widget.orderProduct.fold(0, (sum, item) {
      return sum + ((item.purchasePrice * item.discount / 100) * item.stock);
    });

    double totalTax = widget.orderProduct.fold(0, (sum, item) {
      double discountedPrice = item.purchasePrice - (item.purchasePrice * item.discount / 100);
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
              child: widget.orderProduct.isEmpty ?
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
                itemCount: widget.orderProduct.length,
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
                                  widget.orderProduct[index].product,
                                  style: GoogleFonts.lato(
                                      fontWeight: FontWeight.w600, fontSize: 16),
                                ),
                                Text(
                                  "Price: ${widget.orderProduct[index].purchasePrice.toStringAsFixed(2)}",
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
                                  "Discount: ${widget.orderProduct[index].discount.toStringAsFixed(0)}%",
                                  style: GoogleFonts.lato(color: Colors.grey),
                                ),
                                Text(
                                  "Tax: ${widget.orderProduct[index].tax.toStringAsFixed(0)}%",
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
                                    widget.orderProduct[index].purchasePrice,
                                    widget.orderProduct[index].discount,
                                    widget.orderProduct[index].tax,
                                    widget.orderProduct[index].stock,
                                  )}",style: GoogleFonts.lato(color: Colors.grey),
                                ),
                                CountTextField(
                                  orderProduct: widget.orderProduct,
                                  index: index,
                                  onStockChanged: () {
                                    setState(() {
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
              ),
            ),
            widget.orderProduct.isEmpty ? SizedBox() :
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
            widget.orderProduct.isEmpty ?
            SizedBox() :
            AppButton(
              title: "Save Invoice",
              height: 50,
              width: double.infinity,
              textColor: widget.orderProduct.isEmpty ? AppColor.blackColor : AppColor.whiteColor,
              color: widget.orderProduct.isEmpty ? AppColor.whiteColor : AppColor.primaryColor,
              onTap: (){
                showDialog(
                  context: context,
                  builder: (context){
                    return AlertDialog(
                      title: Text("Summary"),
                      content: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            DropdownSearch<String>(
                              items: (f, cs) => invoice.dropdownCompany,
                              dropdownBuilder: (context, selectedItem) {
                                if (selectedItem == null) {
                                  return Text("Please Select Company");
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
                                  maxHeight: (invoice.dropdownCompany.value.length > 5) ? 300.0 : 150.0,
                                ),
                              ),
                              onChanged: (value) {
                                if (invoice.dropdownCompany.isNotEmpty && invoice.dropdownCompanyId.isNotEmpty) {
                                  int index = invoice.dropdownCompany.indexOf(value!);

                                  // Check if index is valid before accessing dropdownCustomerIds
                                  if (index >= 0 && index < invoice.dropdownCompanyId.length) {
                                    String selectedCustomerId = invoice.dropdownCompanyId[index];
                                    String selectedCustomerName = invoice.dropdownCompany[index];
                                    print("Selected Customer ID: $selectedCustomerId");
                                    print("Selected Customer Name: $selectedCustomerName");
                                    invoice.selectCompanyId.value = selectedCustomerId;
                                    invoice.selectCompany.value = selectedCustomerName;
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
                              title: "Pay Amount",
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
                            onTap: ()async{
                              if(totalAmount < int.parse(invoice.payAmount.text)){
                                Utils.flutterToast("your amount is received is greater than to total amount");
                              }else if(invoice.selectCompany.value.isEmpty){
                                Utils.flutterToast("Please Select Supplier");
                              }else{
                                await invoice.addOrderInvoice(
                                  widget.orderProduct,
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
        inputFormatters:  <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
        cursorColor: AppColor.primaryColor,
        cursorHeight: 18,
        onChanged: (value) {
          if (int.tryParse(value) != null) {
            setState(() {
              widget.orderProduct[widget.index].stock = int.parse(value);
            });
            // Notify the parent widget of the stock change
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

