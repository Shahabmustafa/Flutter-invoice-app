import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/view%20model/firebase/customer_controller.dart';
import 'package:get/get.dart';

import '../../../../../res/component/app_button.dart';
import '../../../../../res/component/invoice_text_field.dart';

class AddCustomer extends StatefulWidget {
  const AddCustomer({Key? key}) : super(key: key);

  @override
  State<AddCustomer> createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  final _key = GlobalKey<FormState>();
  final addCustomer = Get.put(CustomerController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Customer"),
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
                title: "Customer Name",
                controller: addCustomer.customerName.value,
                validator: (value){
                  return value!.isEmpty ? "Enter Your Company Name" : null;
                },
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              InvoiceTextField(
                title: "Customer Email Address",
                controller: addCustomer.customerEmail.value,
                keyboardType: TextInputType.emailAddress,
                validator: (value){
                  return value!.isEmpty ? "Enter Your Email Address" : null;
                },
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              InvoiceTextField(
                title: "Customer Phone Number",
                controller: addCustomer.customerPhone.value,
                keyboardType: TextInputType.phone,
                validator: (value){
                  return value!.isEmpty ? "Enter Your Phone Number" : null;
                },
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              InvoiceTextField(
                title: "Customer Address",
                controller: addCustomer.customerAddress.value,
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
                title: "Customer Payment",
                controller: addCustomer.customerPayment.value,
                validator: (value){
                  return value!.isEmpty ? "Enter Your Item Name" : null;
                },
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              InvoiceTextField(
                title: "Customer CNIC",
                controller: addCustomer.customerCNIC.value,
                keyboardType: TextInputType.number,
                validator: (value){
                  return value!.isEmpty ? "Enter Your Item Price" : null;
                },
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              InvoiceTextField(
                title: "Customer Category",
                controller: addCustomer.customerCategory.value,
                suffix: Text("%"),
                validator: (value){
                  return value!.isEmpty ? "Enter Your Item Whole Price" : null;
                },
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              AppButton(
                title: "Add Customer",
                height: size.height * 0.05,
                width: size.width * 0.94,
                loading: addCustomer.loading.loading.value,
                onTap: (){
                  if(_key.currentState!.validate()){
                    addCustomer.addCustomerData();
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
