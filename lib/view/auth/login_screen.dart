import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/colors/app_colors.dart';
import 'package:flutter_invoice_app/res/component/app_button.dart';
import 'package:flutter_invoice_app/res/component/invoice_text_field.dart';
import 'package:flutter_invoice_app/res/component/social_media_button.dart';
import 'package:flutter_invoice_app/res/routes/routes.dart';
import 'package:flutter_invoice_app/view%20model/auth%20service/login_service.dart';
import 'package:get/get.dart';

import '../../res/assets/assets_url.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _key = GlobalKey<FormState>();
  final loginService = Get.put(LoginService());
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
              height: size.height * 0.1,
            ),
            Form(
              key: _key,
              child: Column(
                children: [
                  InvoiceTextField(
                    title: "Email",
                    controller: loginService.email.value,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icon(Icons.alternate_email),
                    validator: (value){
                      return value!.isEmpty ? "Please Enter Email" : null;
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Obx(() =>
                      InvoiceTextField(
                        title: "Password",
                        controller: loginService.password.value,
                        prefixIcon: Icon(Icons.key),
                        suffixIcon: GestureDetector(
                          onTap: (){
                            loginService.visibility.value =! loginService.visibility.value;
                          },
                          child: Icon(
                            loginService.visibility.value ?
                            Icons.visibility_off_outlined :
                            Icons.visibility,
                          ),
                        ),
                        obscureText: loginService.visibility.value,
                        validator: (value){
                          return value!.isEmpty ? "Please Enter Password" :
                          value.length < 8 ? "Please Enter Eight Digits code" : null;
                        },
                      ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Forget Password",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: AppColor.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Obx(() =>
                      AppButton(
                        title: "Login",
                        height: size.height * 0.06,
                        width: size.width * 0.95,
                        loading: loginService.loading.value,
                        onTap: (){
                          if(_key.currentState!.validate()){
                            loginService.isLogin(context);
                          }
                        },
                      ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.1,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Get.toNamed(AppRoutes.signUp);
                      },
                      child: Text(
                        " Sign Up",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: AppColor.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Flexible(child: Divider(thickness: 3,)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text("or"),
                      ),
                      Flexible(child: Divider(thickness: 3,)),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialMediaButton(
                      imageUrl: AssetsUrl.gmailLogo,
                      onTap: (){
                        Get.toNamed(AppRoutes.listInvoice);
                      },
                    ),
                    SocialMediaButton(
                      imageUrl: AssetsUrl.appleLogo,
                      onTap: (){
                        Get.toNamed(AppRoutes.listInvoice);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
