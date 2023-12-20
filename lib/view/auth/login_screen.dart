import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/model/user_model.dart';
import 'package:flutter_invoice_app/res/colors/app_colors.dart';
import 'package:flutter_invoice_app/res/component/app_button.dart';
import 'package:flutter_invoice_app/res/component/invoice_text_field.dart';
import 'package:flutter_invoice_app/res/component/social_media_button.dart';
import 'package:flutter_invoice_app/res/routes/routes.dart';
import 'package:flutter_invoice_app/utils/utils.dart';
import 'package:flutter_invoice_app/view%20model/auth%20service/google_sign_in.dart';
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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    loginService.email.value.dispose();
    loginService.password.value.dispose();
  }
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
                    title: "login_email_hading".tr,
                    controller: loginService.email.value,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icon(Icons.alternate_email),
                    validator: (value){
                      return value!.isEmpty ? "login_email_validator".tr : null;
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Obx(() =>
                      InvoiceTextField(
                        title: "login_password_hading".tr,
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
                          return value!.isEmpty ? "login_password_validator".tr :
                          value.length < 8 ? "login_password_second_validator".tr : null;
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
                          "forget_password".tr,
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
                        title: "button_login".tr,
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
                      "don't_have_any_account".tr,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.displayLarge!.color,
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Get.toNamed(AppRoutes.signUp);
                      },
                      child: Text(
                        "sign_up_link".tr,
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
                        var date = DateTime.now();
                        var specificId = date.millisecondsSinceEpoch;
                        googleSignIn().signInWithGoogle().then((value){
                          UserModel userModel = UserModel(
                            uid: value.user!.uid,
                            userName: value.user!.displayName,
                            profileImage: value.user!.photoURL,
                            email: value.user!.email,
                            specificId: specificId.toString(),
                            phoneNumber: "",
                            token: "",
                          );
                          FirebaseFirestore.instance
                              .collection("users")
                              .doc(value.user!.uid)
                              .set(userModel.toJson()).then((value){
                            Get.toNamed(AppRoutes.listInvoice);
                          });
                        }).onError((error, stackTrace){
                          Utils.flutterToast(error.toString());
                        });
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
