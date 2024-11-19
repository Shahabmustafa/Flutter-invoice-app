import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/app_api/app_api_service.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../res/colors/app_colors.dart';
import '../../../../res/component/app_button.dart';
import '../../../../res/component/invoice_text_field.dart';

class CustomerInstallmentScreen extends StatefulWidget {
  const CustomerInstallmentScreen({super.key});

  @override
  State<CustomerInstallmentScreen> createState() => _CustomerInstallmentScreenState();
}

class _CustomerInstallmentScreenState extends State<CustomerInstallmentScreen> {

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerController());
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Installment"),
      ),
      body: Column(
        children: [

        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          showDialog(
            context: context,
            builder: (context){
              return AlertDialog(
                title: Text("Add Customer Installment",style: GoogleFonts.lato(fontSize: 16,fontWeight: FontWeight.bold),),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Obx(() {
                        // Wait until the customers list is populated
                        if (controller.customers.isEmpty) {
                          return CircularProgressIndicator(); // Show loading while fetching
                        }

                        return DropdownSearch<String>(
                          items: (f, cs) => controller.customers, // Provide the function returning the list
                          dropdownBuilder: (context, selectedItem) {
                            if (selectedItem == null) {
                              return SizedBox.shrink();
                            }
                            return ListTile(
                              contentPadding: EdgeInsets.only(left: 0),
                              title: Text(selectedItem), // Display the selected customer name
                            );
                          },
                          popupProps: PopupProps.menu(
                            showSearchBox: true,  // Enable the search box
                            showSelectedItems: true,
                            itemBuilder: (ctx, item, isDisabled, isSelected) {
                              return ListTile(
                                selected: isSelected,
                                title: Text(item),  // Display customer name in the popup
                              );
                            },
                          ),
                        );
                      }),
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


class CustomerController extends GetxController {
  var customers = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCustomers();
  }

  // Fetch customer names from Firestore
  void fetchCustomers() async {
    try {
      var snapshot = await AppApiService.customer.get();

      var customerList = snapshot.docs.map((doc) {
        return doc['customerName'] as String; // Assuming each customer document has a 'name' field
      }).toList();
      print(customerList);
      customers.value = customerList; // Update the customers list
    } catch (e) {
      print("Error fetching customers: $e");
    }
  }
}