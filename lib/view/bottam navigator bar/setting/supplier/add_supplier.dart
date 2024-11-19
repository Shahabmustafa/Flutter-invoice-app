import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/view%20model/firebase/supplier_controller.dart';
import 'package:get/get.dart';

import '../../../../../../res/component/app_button.dart';
import '../../../../../../res/component/invoice_text_field.dart';

class AddSupplier extends StatefulWidget {
  const AddSupplier({Key? key}) : super(key: key);

  @override
  State<AddSupplier> createState() => _AddSupplierState();
}

class _AddSupplierState extends State<AddSupplier> {
  final _key = GlobalKey<FormState>();
  final addSupplier = Get.put(SupplierController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Supplier"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Form(
            key: _key,
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.02,
                ),
                InvoiceTextField(
                  title: "Company Name",
                  hintText: "Full Name",
                  controller: addSupplier.companyName.value,
                  validator: (value){
                    return value!.isEmpty ? "Enter Your Company Name" : null;
                  },
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                InvoiceTextField(
                  title: "Company Email",
                  hintText: "Email Address",
                  controller: addSupplier.companyEmail.value,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value){
                    return value!.isEmpty ? "Enter Your Email" : null;
                  },
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                InvoiceTextField(
                  title: "Company Phone No",
                  hintText: "Phone No",
                  controller: addSupplier.companyPhoneNumber.value,
                  keyboardType: TextInputType.phone,
                  validator: (value){
                    return value!.isEmpty ? "Enter Your Phone No" : null;
                  },
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                InvoiceTextField(
                  title: "Company Address",
                  hintText: "Address",
                  controller: addSupplier.companyAddress.value,
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  validator: (value){
                    return value!.isEmpty ? "Enter Company Address" : null;
                  },
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                InvoiceTextField(
                  title: "Supplier Name",
                  hintText: "Supplier Name",
                  controller: addSupplier.supplierName.value,
                  validator: (value){
                    return value!.isEmpty ? "Enter Your Item Name" : null;
                  },
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                InvoiceTextField(
                  title: "Supplier Phone No",
                  hintText: "Phone No",
                  controller: addSupplier.supplierPhoneNumber.value,
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
                  hintText: "Email",
                  controller: addSupplier.supplierEmail.value,
                  validator: (value){
                    return value!.isEmpty ? "Enter Your Item Whole Price" : null;
                  },
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                AppButton(
                  title: "Add Supplier",
                  height: size.height * 0.05,
                  width: size.width * 0.94,
                  loading: addSupplier.loading.loading.value,
                  onTap: (){
                    if(_key.currentState!.validate()){
                      addSupplier.addSupplier();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
