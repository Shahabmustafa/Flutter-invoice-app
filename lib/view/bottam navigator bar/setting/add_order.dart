import 'package:flutter/material.dart';

import '../../../res/component/app_button.dart';
import '../../../res/component/invoice_text_field.dart';

class AddOrder extends StatefulWidget {
  const AddOrder({Key? key}) : super(key: key);

  @override
  State<AddOrder> createState() => _AddOrderState();
}

class _AddOrderState extends State<AddOrder> {

  final _key = GlobalKey<FormState>();
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
                height: size.height * 0.05,
              ),
              InvoiceTextField(
                title: "Item Name",
                // controller: addSupplier.companyName.value,
                validator: (value){
                  return value!.isEmpty ? "Enter Your Company Name" : null;
                },
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
                    // addSupplier.addSupplier();
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
