import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/colors/app_colors.dart';

import '../../../../res/app_api/app_api_service.dart';
import '../../../../res/component/app_button.dart';
import '../../../../res/component/invoice_text_field.dart';

class AddOrder extends StatefulWidget {
  const AddOrder({Key? key}) : super(key: key);

  @override
  State<AddOrder> createState() => _AddOrderState();
}

class _AddOrderState extends State<AddOrder> {

  final _key = GlobalKey<FormState>();

  String? selectedDropdownValue;
  List<String> dropdownItems = [];

  Future<List<String>> fetchDropdownDataFromFirebase() async {
    List<String> dropdownItems = [];
    try {
      QuerySnapshot querySnapshot = await AppApiService.item.get();
      if (querySnapshot.docs.isNotEmpty) {
        dropdownItems = querySnapshot.docs.map((doc) => doc['itemName'].toString()).toList();
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
    return dropdownItems;
  }

  Future<void> fetchDataAndSetState() async {
    List<String> data = await fetchDropdownDataFromFirebase();
    setState(() {
      dropdownItems = data;
    });
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Order"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FormField<String>(
                  builder: (FormFieldState<String> state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Item Name',
                        errorText: state.errorText,
                        border: InputBorder.none,
                      ),
                      isEmpty: selectedDropdownValue == null || selectedDropdownValue!.isEmpty,
                      child: DropdownButtonFormField<String>(
                        value: selectedDropdownValue,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        items: dropdownItems.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedDropdownValue = value;
                          });
                          state.didChange(value);
                        },
                      ),
                    );
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select an option';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              InvoiceTextField(
                title: "",
                keyboardType: TextInputType.emailAddress,
                validator: (value){
                  return value!.isEmpty ? "Enter Your Email Address" : null;
                },
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              InvoiceTextField(
                title: "Company Phone Number",
                // controller: addSupplier.companyPhoneNumber.value,
                keyboardType: TextInputType.phone,
                validator: (value){
                  return value!.isEmpty ? "Enter Your Phone Number" : null;
                },
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              InvoiceTextField(
                title: "Company Address",
                // controller: addSupplier.companyAddress.value,
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                validator: (value){
                  return value!.isEmpty ? "Enter Your Address" : null;
                },
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              InvoiceTextField(
                title: "Supplier Name",
                // controller: addSupplier.supplierName.value,
                validator: (value){
                  return value!.isEmpty ? "Enter Your Item Name" : null;
                },
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              InvoiceTextField(
                title: "Supplier Phone Number",
                // controller: addSupplier.supplierPhoneNumber.value,
                keyboardType: TextInputType.number,
                validator: (value){
                  return value!.isEmpty ? "Enter Your Item Price" : null;
                },
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              InvoiceTextField(
                title: "Supplier Email",
                // controller: addSupplier.supplierEmail.value,
                suffix: Text("%"),
                validator: (value){
                  return value!.isEmpty ? "Enter Your Item Whole Price" : null;
                },
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              AppButton(
                title: "Add Order",
                height: size.height * 0.05,
                width: size.width * 0.94,
                // loading: addSupplier.loading.loading.value,
                onTap: (){
                  if(_key.currentState!.validate()){
                    dropdownItems.toString();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
