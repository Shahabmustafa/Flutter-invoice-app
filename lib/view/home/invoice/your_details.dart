import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/component/app_button.dart';
import 'package:flutter_invoice_app/res/component/invoice_text_field.dart';

import '../../../res/component/drop_down_image.dart';

class YourDetails extends StatefulWidget {
  const YourDetails({Key? key}) : super(key: key);

  @override
  State<YourDetails> createState() => _YourDetailsState();
}

class _YourDetailsState extends State<YourDetails> {
  final _key = GlobalKey<FormState>();
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
                validator: (value){
                  return value!.isEmpty ? "Enter Your Business Name" : null;
                },
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              InvoiceTextField(
                title: "Email Address",
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
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                validator: (value){
                  return value!.isEmpty ? "Enter Your Parmanent Address" : null;
                },
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              DropDownImage(
                onTap: (){
                  print("onTap");
                },
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              AppButton(
                title: "Save",
                height: size.height * 0.05,
                width: size.width * 0.4,
                onTap: (){
                  if(_key.currentState!.validate()){

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
