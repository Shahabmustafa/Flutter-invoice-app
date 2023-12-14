import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../res/component/app_button.dart';
import '../../../../res/component/invoice_text_field.dart';
import '../../../../view model/invoice service/inoice_service.dart';

class AddCustomer extends StatefulWidget {
  const AddCustomer({Key? key}) : super(key: key);

  @override
  State<AddCustomer> createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  final _key = GlobalKey<FormState>();
  final invoiceService = Get.put(InvoiceService());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Customer"),
      ),
      body: Form(
        key: _key,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.02,
            ),
            InvoiceTextField(
              title: "Customer Name",
              controller: invoiceService.businessName.value,
              validator: (value){
                return value!.isEmpty ? "Enter Your Customer Name" : null;
              },
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            InvoiceTextField(
              title: "Email Address",
              // controller: business.email.value,
              controller: invoiceService.businessEmail.value,
              validator: (value){
                return value!.isEmpty ? "Please Enter Your Email" : null;
              },
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            InvoiceTextField(
              title: "Phone Number",
              controller: invoiceService.businessNumber.value,
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
              controller: invoiceService.businessAddress.value,
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              validator: (value){
                return value!.isEmpty ? "Enter Your Parmanent Address" : null;
              },
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Obx(() => AppButton(
              title: "Save",
              height: size.height * 0.05,
              width: size.width * 0.94,
              loading: invoiceService.loading.value,
              onTap: (){
                if(_key.currentState!.validate()){

                }
              },
            ),
            ),
          ],
        ),
      ),
    );
  }
}
