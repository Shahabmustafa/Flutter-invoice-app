import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/view%20model/firebase/customer_controller.dart';
import 'package:get/get.dart';

import '../../../../../res/component/app_button.dart';
import '../../../../../res/component/invoice_text_field.dart';

class EditCustomerScreen extends StatefulWidget {
  const EditCustomerScreen({Key? key}) : super(key: key);

  @override
  State<EditCustomerScreen> createState() => _EditCustomerScreenState();
}

class _EditCustomerScreenState extends State<EditCustomerScreen> {
  final _key = GlobalKey<FormState>();
  final editCustomer = Get.put(CustomerController());
  var customer = Get.arguments;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    editCustomer.customerName.value = TextEditingController(text: customer[0]);
    editCustomer.customerEmail.value= TextEditingController(text: customer[1]);
    editCustomer.customerPhone.value = TextEditingController(text: customer[2]);
    editCustomer.customerAddress.value = TextEditingController(text: customer[3]);
    editCustomer.customerPayment.value = TextEditingController(text: customer[4].toString());
    editCustomer.customerCNIC.value = TextEditingController(text: customer[5]);
    editCustomer.customerCategory.value = TextEditingController(text: customer[6]);
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Customer"),
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
                  title: "Customer Name",
                  hintText: "Full Name",
                  controller: editCustomer.customerName.value,
                  validator: (value){
                    return value!.isEmpty ? "Enter Your Company Name" : null;
                  },
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                InvoiceTextField(
                  title: "Customer Email",
                  hintText: "Email Address",
                  controller: editCustomer.customerEmail.value,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value){
                    return value!.isEmpty ? "Enter Your Email Address" : null;
                  },
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                InvoiceTextField(
                  title: "Customer CNIC",
                  hintText: "CNIC",
                  controller: editCustomer.customerCNIC.value,
                  keyboardType: TextInputType.number,
                  validator: (value){
                    return value!.isEmpty ? "Enter Your Item Price" : null;
                  },
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                InvoiceTextField(
                  title: "Customer Phone",
                  hintText: "Phone No",
                  controller: editCustomer.customerPhone.value,
                  keyboardType: TextInputType.phone,
                  validator: (value){
                    return value!.isEmpty ? "Enter Your Phone" : null;
                  },
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                InvoiceTextField(
                  title: "Customer Address",
                  hintText: "Address",
                  controller: editCustomer.customerAddress.value,
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
                  hintText: "0",
                  enabled: false,
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                InvoiceTextField(
                  title: "Customer Category",
                  controller: editCustomer.customerCategory.value,
                  validator: (value){
                    return value!.isEmpty ? "Enter Your Item Whole Price" : null;
                  },
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Obx((){
                  return AppButton(
                    title: "Add Customer",
                    height: size.height * 0.05,
                    width: size.width * 0.94,
                    loading: editCustomer.loading.value,
                    onTap: (){
                      if(_key.currentState!.validate()){
                        editCustomer.editCustomerData(customer[7]);
                      }
                    },
                  );
                }),
                SizedBox(
                  height: size.height * 0.05,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
