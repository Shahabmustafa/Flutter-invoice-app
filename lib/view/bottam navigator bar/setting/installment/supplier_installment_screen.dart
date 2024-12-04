import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/colors/app_colors.dart';
import 'package:flutter_invoice_app/res/component/app_button.dart';
import 'package:flutter_invoice_app/res/component/invoice_text_field.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../view model/firebase/supplier_installment_viewmodel.dart';

class SupplierInstallmentScreen extends StatefulWidget {
  const SupplierInstallmentScreen({super.key});

  @override
  State<SupplierInstallmentScreen> createState() => _SupplierInstallmentScreenState();
}

class _SupplierInstallmentScreenState extends State<SupplierInstallmentScreen> {
  final controller = Get.put(SupplierInstallmentViewModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Supplier Installment"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("supplierInstallment").orderBy("date",descending: true).snapshots(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            if(snapshot.data!.docs.isEmpty){
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.money_dollar_circle,color: AppColor.primaryColor,size: 100,),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      "Supplier Installment is Empty",
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
                itemBuilder: (context,index){
                  DateTime dateTime = snapshot.data!.docs[index]["date"].toDate();
                  String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                    child: Card(
                      child: ListTile(
                        leading: Text("${index + 1}"),
                        title: Text(snapshot.data!.docs[index]["supplierName"]),
                        subtitle: Text(formattedDate),
                        trailing: Text(snapshot.data!.docs[index]["payBalance"]),
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
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          showDialog(
            context: context,
            builder: (context){
              return StatefulBuilder(
                builder: (context,setState){
                  return AlertDialog(
                    title: Text("Add Supplier Installment",style: GoogleFonts.lato(fontSize: 16,fontWeight: FontWeight.bold),),
                    content: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Obx(() {
                            if (controller.dropdownSupplier.isEmpty) {
                              return CircularProgressIndicator();
                            }
                            return DropdownSearch<String>(
                              items: (f, cs) => controller.dropdownSupplier,
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
                              ),
                              onChanged: (value) {
                                if (controller.dropdownSupplier.isNotEmpty && controller.dropdownSupplierIds.isNotEmpty) {
                                  int index = controller.dropdownSupplier.indexOf(value!);
                                  setState((){});
                                  // Check if index is valid before accessing dropdownCustomerIds
                                  if (index >= 0 && index < controller.dropdownSupplierIds.length) {
                                    String selectedSupplierId = controller.dropdownSupplierIds[index];
                                    String selectedSupplierName = controller.dropdownSupplier[index];
                                    String selectedSupplierPayment = controller.dropdownSupplierPayment[index];
                                    print("Selected Customer ID: $selectedSupplierId");
                                    print("Selected Customer Name: $selectedSupplierName");
                                    print("Selected Customer Payment: $selectedSupplierPayment");
                                    controller.selectSupplierId.value = selectedSupplierId;
                                    controller.selectSupplier.value = selectedSupplierName;
                                    controller.selectSupplierPayment.value = selectedSupplierPayment;
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
                            title: "Supplier Amount",
                            controller: TextEditingController(text: controller.selectSupplierPayment.value),
                          ),
                          SizedBox(height: 10,),
                          InvoiceTextField(
                            title: "Receive Cash",
                            controller: controller.recivedAmount,
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
                                    controller.SupplierInstallment();
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
