import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/component/app_button.dart';
import 'package:flutter_invoice_app/res/component/invoice_text_field.dart';
import 'package:flutter_invoice_app/view%20model/image_picker/image_picker_service.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../res/component/drop_down_image.dart';
import '../../../view model/invoice service/new_business_service.dart';

class YourDetails extends StatefulWidget {
  const YourDetails({Key? key}) : super(key: key);

  @override
  State<YourDetails> createState() => _YourDetailsState();
}

class _YourDetailsState extends State<YourDetails> {
  final _key = GlobalKey<FormState>();
  final business = Get.put(NewBusinessService());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("New Business"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.02,
              ),
              InvoiceTextField(
                title: "Business Name",
                controller: business.businessName.value,
                validator: (value){
                  return value!.isEmpty ? "Enter Your Business Name" : null;
                },
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              InvoiceTextField(
                title: "Email Address",
                controller: business.email.value,
                keyboardType: TextInputType.emailAddress,
                validator: (value){
                  return value!.isEmpty ? "Please Enter Your Email" : null;
                },
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              InvoiceTextField(
                title: "Phone Number",
                controller: business.phoneNumber.value,
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
                controller: business.address.value,
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                validator: (value){
                  return value!.isEmpty ? "Enter Your Parmanent Address" : null;
                },
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              DropDownImage(),
              SizedBox(
                height: size.height * 0.02,
              ),
              Obx(() => AppButton(
                title: "Save",
                height: size.height * 0.05,
                width: size.width * 0.94,
                loading: business.loading.value,
                onTap: (){
                  if(_key.currentState!.validate()){
                    business.newBusiness(context);
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
