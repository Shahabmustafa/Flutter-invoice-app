

import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/view%20model/auth%20service/signup_service.dart';
import 'package:get/get.dart';

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
  final signUpService = Get.put(SignUpService());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.1,
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
                    title: "signup_userName_hading".tr,
                    controller: signUpService.userName.value,
                    prefixIcon: Icon(Icons.person),
                    validator: (value){
                      return value!.isEmpty ? "signup_userName_validator".tr : null;
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  InvoiceTextField(
                    title: "signup_email_hading".tr,
                    controller: signUpService.email.value,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icon(Icons.alternate_email),
                    validator: (value){
                      return value!.isEmpty ? "signup_email_validator".tr : null;
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Obx(() =>
                      InvoiceTextField(
                        title: "signup_password_hading".tr,
                        controller: signUpService.password.value,
                        prefixIcon: Icon(Icons.key),
                        suffixIcon: GestureDetector(
                          onTap: (){
                            signUpService.Visibility.value =! signUpService.Visibility.value;
                          },
                          child: Icon(
                            signUpService.Visibility.value ?
                            Icons.visibility_off_outlined :
                            Icons.visibility,
                          ),
                        ),
                        obscureText: signUpService.Visibility.value,
                        validator: (value){
                          return value!.isEmpty ? "signup_password_validator".tr :
                          value.length < 8 ? "signup_password_second_validator".tr : null;
                        },
                      ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Obx(() =>
                      InvoiceTextField(
                        title: "signup_con_password_hading".tr,
                        controller: signUpService.conPassword.value,
                        prefixIcon: Icon(Icons.key),
                        suffixIcon: GestureDetector(
                          onTap: (){
                            signUpService.confirmVisibility.value =! signUpService.confirmVisibility.value;
                          },
                          child: Icon(
                            signUpService.confirmVisibility.value ?
                            Icons.visibility_off_outlined :
                            Icons.visibility,
                          ),
                        ),
                        obscureText: signUpService.confirmVisibility.value,
                        validator: (value){
                          return signUpService.conPassword.value.text.isEmpty ? "signup_con_password_validator".tr :
                          signUpService.conPassword.value.text != signUpService.password.value.text ? "signup_con_password_second_validator".tr : null;
                        },
                      ),
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Obx(() =>
                      AppButton(
                        title: "button_signUp".tr,
                        height: size.height * 0.06,
                        width: size.width * 0.95,
                        loading: signUpService.loading.value,
                        onTap: (){
                          if(_key.currentState!.validate()){
                            signUpService.isSignUp(context);
                          }
                        },
                      ),
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
                  "already_have_an_account".tr,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.displayLarge!.color,
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: Text(
                    "sign_in_link".tr,
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
