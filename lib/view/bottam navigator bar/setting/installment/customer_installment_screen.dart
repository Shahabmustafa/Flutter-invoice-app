import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../res/colors/app_colors.dart';
import '../../../../res/component/app_button.dart';
import '../../../../res/component/dashboard_summary.dart';
import '../../../../res/component/invoice_text_field.dart';
import '../../../../utils/utils.dart';
import '../../../../view model/firebase/customer_installment_viewmodel.dart';

class CustomerInstallmentScreen extends StatefulWidget {
  const CustomerInstallmentScreen({super.key});

  @override
  State<CustomerInstallmentScreen> createState() => _CustomerInstallmentScreenState();
}

class _CustomerInstallmentScreenState extends State<CustomerInstallmentScreen> {

  List<int> days = [1,7,14,30,60];
  int selectValue = 1;


  DateTime get startDate {
    return DateTime.now().subtract(Duration(days: selectValue));
  }
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerInstallmentViewModel());
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Installment"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("users").
        doc(FirebaseAuth.instance.currentUser!.uid).
        collection("customerInstallment").where("date", isGreaterThanOrEqualTo: Timestamp.fromDate(startDate)).
        orderBy("date", descending: true).snapshots(),
        builder: (context,snapshot){
          if (snapshot.hasData) {
            double totalInstallment = 0.0;
            for (var doc in snapshot.data!.docs) {
              totalInstallment += double.parse(doc["payBalance"].toString());
            }
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: DashboardSummary(
                          imageAssets: Icon(CupertinoIcons.calendar),
                          title: "Installment",
                          subtitle: "${totalInstallment.toStringAsFixed(0)}",
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 60,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: days.length,
                    itemBuilder: (context, index) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: selectValue == days[index]
                                  ? Colors.blue
                                  : Colors.grey[300],
                              foregroundColor: selectValue == days[index]
                                  ? Colors.white
                                  : Colors.black,
                              minimumSize: Size(80, 40),
                            ),
                            onPressed: () {
                              setState(() {
                                selectValue = days[index];
                              });
                            },
                            child: Text("${days[index]} Days"),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DateTime dateTime =
                      snapshot.data!.docs[index]["date"].toDate();
                      String formattedDate =
                      DateFormat("dd-MM-yyyy hh:mm a").format(dateTime);
                      return Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Card(
                          child: ListTile(
                            title: Text(snapshot.data!.docs[index]["customerName"]),
                            subtitle: Text(formattedDate),
                            trailing: Text(
                              "Rs. ${snapshot.data!.docs[index]["payBalance"]}",
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return Center(child: Utils.circular);
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          showDialog(
            context: context,
            builder: (context){
              return StatefulBuilder(
                builder: (context,setState){
                  return AlertDialog(
                    title: Text("Add Customer Installment",style: GoogleFonts.lato(fontSize: 16,fontWeight: FontWeight.bold),),
                    content: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Obx(() {
                            if (controller.dropdownCustomer.isEmpty) {
                              return CircularProgressIndicator();
                            }
                            return DropdownSearch<String>(
                              items: (f, cs) => controller.dropdownCustomer,
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
                                  maxHeight: (controller.dropdownCustomer.value.length > 5) ? 300.0 : 150.0,
                                ),
                              ),
                              onChanged: (value) {
                                if (controller.dropdownCustomer.isNotEmpty && controller.dropdownCustomerIds.isNotEmpty) {
                                  int index = controller.dropdownCustomer.indexOf(value!);
                                  setState((){});
                                  // Check if index is valid before accessing dropdownCustomerIds
                                  if (index >= 0 && index < controller.dropdownCustomerIds.length) {
                                    String selectedCustomerId = controller.dropdownCustomerIds[index];
                                    String selectedCustomerName = controller.dropdownCustomer[index];
                                    String selectedCustomerPayment = controller.dropdownCustomerPayment[index];
                                    print("Selected Customer ID: $selectedCustomerId");
                                    print("Selected Customer Name: $selectedCustomerName");
                                    print("Selected Customer Payment: $selectedCustomerPayment");
                                    controller.selectCustomerId.value = selectedCustomerId;
                                    controller.selectCustomer.value = selectedCustomerName;
                                    controller.selectCustomerPayment.value = selectedCustomerPayment;
                                  } else {
                                    print("Invalid index or empty lists");
                                  }
                                } else {
                                  print("Customer data is not loaded or empty");
                                }
                              },
                            );
                          }),
                          SizedBox(height: 10,),
                          InvoiceTextField(
                            title: "Customer Amount",
                            controller: TextEditingController(text: controller.selectCustomerPayment.value),
                            enabled: false,
                          ),
                          SizedBox(height: 10,),
                          InvoiceTextField(
                            title: "Receive Cash",
                            controller: controller.recivedAmount,
                            onlyNumber: true,
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
                                onTap: (){
                                  Get.back();
                                },
                              ),
                              Obx((){
                                return AppButton(
                                  height: 45,
                                  width: 100,
                                  title: "Add",
                                  loading: controller.loading.value,
                                  onTap: (){
                                    controller.customerInstallment();
                                  },
                                );
                              }),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
        label: Text("Add Installment"),
      ),

    );
  }
}

