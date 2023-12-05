

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../res/assets/assets_url.dart';
import '../../res/colors/app_colors.dart';
import '../../res/component/app_button.dart';
import '../../res/component/invoice_text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.05,
            ),
            Center(
              child: Image.asset(
                AssetsUrl.appLogo,
                height: size.height * 0.1,
                width: size.width * 0.2,
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Form(
              key: _key,
              child: Column(
                children: [
                  InvoiceTextField(
                    title: "User Name",
                    prefixIcon: Icon(Icons.person),
                    validator: (value){
                      return value!.isEmpty ? "Please Enter Your User Name" : null;
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  InvoiceTextField(
                    title: "Email",
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icon(Icons.alternate_email),
                    validator: (value){
                      return value!.isEmpty ? "Please Enter Email" : null;
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  InvoiceTextField(
                    title: "Password",
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icon(Icons.key),
                    suffixIcon: Icon(Icons.visibility_off_outlined),
                    obscureText: false,
                    validator: (value){
                      return value!.isEmpty ? "Please Enter Password" :
                      value.length < 8 ? "Please Enter Eight Digits code" : null;
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  InvoiceTextField(
                    title: "Confirm Password",
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icon(Icons.key),
                    suffixIcon: Icon(Icons.visibility_off_outlined),
                    obscureText: false,
                    validator: (value){
                      return value!.isEmpty ? "Please Enter Password" :
                      value.length < 8 ? "Please Enter Eight Digits code" : null;
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  AppButton(
                    title: "Sign Up",
                    height: size.height * 0.06,
                    width: size.width * 0.95,
                    onTap: (){
                      if(_key.currentState!.validate()){
                        
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: Text(
                    " Sign in",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: AppColor.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
