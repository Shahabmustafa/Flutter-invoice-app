import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/assets/assets_url.dart';
import 'package:flutter_invoice_app/res/colors/app_colors.dart';
import 'package:flutter_invoice_app/res/component/app_button.dart';
import 'package:flutter_invoice_app/res/routes/routes.dart';
import 'package:flutter_invoice_app/view%20model/firebase/change_password_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {

  final changePassword = Get.put(ChangePasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Password"),
      ),
      body: Obx((){
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: kToolbarHeight,),
                Center(child: AssetsUrl.changePasswordHeadIconSvgIcon),
                SizedBox(height: 10,),
                Text("Verification",style: GoogleFonts.lato(fontSize: 30,fontWeight: FontWeight.w800,color: AppColor.primaryColor),),
                Text("Change your Password.!",style: GoogleFonts.lato(fontSize: 30,fontWeight: FontWeight.w800),),
                Text("We are use just simply dummy Password.",style: GoogleFonts.lato(),),
                SizedBox(height: 30,),
                Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Enter Old Password",style: GoogleFonts.lato(fontSize: 20,fontWeight: FontWeight.w800,),),
                      SizedBox(height: 15,),
                      TextFormField(
                        cursorColor: AppColor.primaryColor,
                        obscureText: changePassword.oldPassword.value,
                        controller: changePassword.oldPasswordController.value,
                        decoration: InputDecoration(
                          hintText: "Old Password",
                          suffixIcon: GestureDetector(
                            onTap: (){
                              changePassword.oldPassword.value =! changePassword.oldPassword.value;
                            },
                            child: Icon(changePassword.oldPassword.value ? Icons.visibility_off : Icons.visibility),
                          ),
                        ),
                      ),
                      SizedBox(height: 15,),
                      TextFormField(
                        cursorColor: AppColor.primaryColor,
                        obscureText: changePassword.newPassword.value,
                        controller: changePassword.updatePasswordController.value,
                        decoration: InputDecoration(
                          hintText: "New Password",
                          suffixIcon: GestureDetector(
                            onTap: (){
                              changePassword.newPassword.value =! changePassword.newPassword.value;
                            },
                            child: Icon(changePassword.newPassword.value ? Icons.visibility_off : Icons.visibility),
                          ),
                        ),
                      ),
                      SizedBox(height: 15,),
                      TextFormField(
                        cursorColor: AppColor.primaryColor,
                        obscureText: changePassword.confirmPassword.value,
                        controller: changePassword.confirmPasswordController.value,
                        decoration: InputDecoration(
                          hintText: "Confirm Password",
                          suffixIcon: GestureDetector(
                            onTap: (){
                              changePassword.confirmPassword.value =! changePassword.confirmPassword.value;
                            },
                            child: Icon(changePassword.confirmPassword.value ? Icons.visibility_off : Icons.visibility),
                          ),
                        ),
                      ),
                      SizedBox(height: 15,),
                      AppButton(
                        title: "Continue",
                        height: 55,
                        width: double.infinity,
                        loading: changePassword.loading.value,
                        onTap: (){
                          changePassword.isChangePassword();
                        },
                      ),
                      SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: (){
                              Get.toNamed(AppRoutes.forgetPasswordScreen);
                            },
                            child: Text("Forget Password"),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
