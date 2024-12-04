import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/component/app_button.dart';
import 'package:flutter_invoice_app/res/component/invoice_text_field.dart';
import 'package:get/get.dart';

import '../../res/assets/assets_url.dart';
import '../../view model/auth service/forget_password_controller.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _key = GlobalKey<FormState>();
  final forgetPassword = Get.put(ForgetPasswordController());
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    forgetPassword.email.value.dispose();
  }
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
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
                      title: "login_email_hading".tr,
                      hintText: "Enter Email",
                      controller: forgetPassword.email.value,
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: Icon(Icons.alternate_email),
                      validator: (value){
                        return value!.isEmpty ? "login_email_validator".tr : null;
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Obx(() =>
                        AppButton(
                          title: "Continue",
                          height: size.height * 0.06,
                          width: size.width * 0.95,
                          loading: forgetPassword.loading.value,
                          onTap: (){
                            if(_key.currentState!.validate()){
                              forgetPassword.isForgetPassword();
                            }
                          },
                        ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
