import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/view%20model/invoice%20service/customer_service.dart';
import 'package:get/get.dart';
import '../../../../res/component/app_button.dart';
import '../../../../res/component/invoice_text_field.dart';

class AddCustomer extends StatefulWidget {
  const AddCustomer({Key? key}) : super(key: key);

  @override
  State<AddCustomer> createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  final _key = GlobalKey<FormState>();
  final customerService = Get.put(CustomerService());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("New Customer"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.15,
              ),
              InvoiceTextField(
                title: "Customer Name",
                controller: customerService.customerName.value,
                validator: (value){
                  return value!.isEmpty ? "Enter Your Customer Name" : null;
                },
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              InvoiceTextField(
                title: "Email Address",
                controller: customerService.customerEmail.value,
                keyboardType: TextInputType.emailAddress,
                validator: (value){
                  return value!.isEmpty ? "Enter Your Email Address" : null;
                },
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              InvoiceTextField(
                controller: customerService.customerPhone.value,
                title: "Phone Number",
                keyboardType: TextInputType.phone,
                validator: (value){
                  return value!.isEmpty ? "Enter Your Phone Number" : null;
                },
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              InvoiceTextField(
                title: "Address",
                controller: customerService.customerAddress.value,
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                validator: (value){
                  return value!.isEmpty ? "Enter Your Address" : null;
                },
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Obx(()=>
                  AppButton(
                    title: "Save",
                    height: size.height * 0.05,
                    width: size.width * 0.94,
                    loading: customerService.loading.value,
                    onTap: ()async{
                      if(_key.currentState!.validate()){
                        customerService.customerService(context);
                      }
                    },
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
