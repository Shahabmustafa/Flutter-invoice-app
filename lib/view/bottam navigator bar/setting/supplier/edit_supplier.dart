import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/view%20model/firebase/supplier_controller.dart';
import 'package:get/get.dart';

import '../../../../res/component/app_button.dart';
import '../../../../res/component/invoice_text_field.dart';

class EditSupplier extends StatefulWidget {
  const EditSupplier({Key? key}) : super(key: key);

  @override
  State<EditSupplier> createState() => _EditSupplierState();
}

class _EditSupplierState extends State<EditSupplier> {
  final _key = GlobalKey<FormState>();
  final editSupplier = Get.put(SupplierController());
  final supplier = Get.arguments;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    var supplierId = supplier[0];
    TextEditingController updateCompany = TextEditingController(text: supplier[1]);
    TextEditingController updateCompanyEmail= TextEditingController(text: supplier[2]);
    TextEditingController updatePhoneNumber = TextEditingController(text: supplier[3]);
    TextEditingController updateAddress = TextEditingController(text: supplier[4]);
    TextEditingController updateSupplierName = TextEditingController(text: supplier[5]);
    TextEditingController updateSupplierPhone = TextEditingController(text: supplier[6]);
    TextEditingController updateSupplierEmail = TextEditingController(text: supplier[7]);
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Supplier"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: _key,
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.05,
                ),
                InvoiceTextField(
                  title: "Company Name",
                  controller: updateCompany,
                  validator: (value){
                    return value!.isEmpty ? "Enter Your Company Name" : null;
                  },
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                InvoiceTextField(
                  title: "Company Email Address",
                  controller: updateCompanyEmail,
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
                  controller: updatePhoneNumber,
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
                  controller: updateAddress,
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
                  controller: updateSupplierName,
                  validator: (value){
                    return value!.isEmpty ? "Enter Your Item Name" : null;
                  },
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                InvoiceTextField(
                  title: "Supplier Phone Number",
                  controller: updateSupplierPhone,
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
                  controller: updateSupplierEmail,
                  validator: (value){
                    return value!.isEmpty ? "Enter Your Item Whole Price" : null;
                  },
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Obx((){
                  return AppButton(
                    title: "Update Supplier",
                    height: size.height * 0.05,
                    width: size.width * 0.94,
                    loading: editSupplier.loading.loading.value,
                    onTap: (){
                      if(_key.currentState!.validate()){
                        editSupplier.editSupplier(
                          supplierId: supplierId,
                          companyName: updateCompany.text,
                          companyEmail: updateCompanyEmail.text,
                          companyPhone: updatePhoneNumber.text,
                          companyAddress: updateAddress.text,
                          supplierName: updateSupplierName.text,
                          supplierEmail: updateSupplierEmail.text,
                          supplierPhone: updateSupplierPhone.text,
                        );

                      }
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
