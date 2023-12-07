

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../res/component/app_button.dart';
import '../../../res/component/invoice_text_field.dart';
import '../../../view model/invoice service/inoice_service.dart';

class AddPayer extends StatefulWidget {
  const AddPayer({Key? key}) : super(key: key);

  @override
  State<AddPayer> createState() => _AddPayerState();
}

class _AddPayerState extends State<AddPayer> {
  final _key = GlobalKey<FormState>();
  final invoiceService = Get.put(InvoiceService());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("New Payer"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.2,
              ),
              InvoiceTextField(
                title: "Payer Name",
                controller: invoiceService.payerName.value,
                validator: (value){
                  return value!.isEmpty ? "Enter Your Payer Name" : null;
                },
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              InvoiceTextField(
                title: "Email Address",
                controller: invoiceService.payerEmail.value,
                keyboardType: TextInputType.emailAddress,
                validator: (value){
                  return value!.isEmpty ? "Enter Your Email Address" : null;
                },
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              InvoiceTextField(
                controller: invoiceService.payerNumber.value,
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
                controller: invoiceService.payerAddress.value,
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
                    loading: invoiceService.loading.value,
                    onTap: (){
                      if(_key.currentState!.validate()){
                        // payer.Payer(context);
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
