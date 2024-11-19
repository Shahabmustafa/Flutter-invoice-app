import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/colors/app_colors.dart';
import 'package:flutter_invoice_app/res/component/app_button.dart';
import 'package:flutter_invoice_app/res/component/invoice_text_field.dart';
import 'package:google_fonts/google_fonts.dart';

class SupplierInstallmentScreen extends StatefulWidget {
  const SupplierInstallmentScreen({super.key});

  @override
  State<SupplierInstallmentScreen> createState() => _SupplierInstallmentScreenState();
}

class _SupplierInstallmentScreenState extends State<SupplierInstallmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Supplier Installment"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          showDialog(
            context: context,
            builder: (context){
              return AlertDialog(
                title: Text("Add Supplier Installment",style: GoogleFonts.lato(fontSize: 16,fontWeight: FontWeight.bold),),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DropdownSearch<String>(
                        items: (f, cs) => ["a", "b", "c"],
                        dropdownBuilder: (context, selectedItem) {
                          if (selectedItem == null) {
                            return SizedBox.shrink();
                          }
                          return ListTile(
                            contentPadding: EdgeInsets.only(left: 0),
                            title: Text(selectedItem),
                          );
                        },
                        popupProps: PopupProps.menu(
                          showSearchBox: true,  // Enable the search box
                          showSelectedItems: true,
                          itemBuilder: (ctx, item, isDisabled, isSelected) {
                            return ListTile(
                              selected: isSelected,
                              title: Text(item),  // Display the item in the popup
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 10,),
                      InvoiceTextField(
                        title: "Total Cash",
                      ),
                      SizedBox(height: 10,),
                      InvoiceTextField(
                        title: "Receive Cash",
                      ),
                      SizedBox(height: 20,),
                      InvoiceTextField(
                        title: "Due Cash",
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppButton(
                            height: 45,
                            width: 100,
                            color: AppColor.whiteColor,
                            title: "Cancel",
                            textColor: AppColor.blackColor,
                          ),
                          AppButton(
                            height: 45,
                            width: 100,
                            title: "Add",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        label: Text("Add Installment"),
      ),
    );
  }
}
