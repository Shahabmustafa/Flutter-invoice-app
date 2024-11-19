import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/assets/assets_url.dart';
import 'package:flutter_invoice_app/res/colors/app_colors.dart';
import 'package:flutter_invoice_app/res/component/app_button.dart';
import 'package:flutter_invoice_app/res/component/invoice_text_field.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Old Password",
                        suffixIcon: Icon(Icons.visibility_off),
                      ),
                    ),
                    SizedBox(height: 15,),
                    TextFormField(
                      cursorColor: AppColor.primaryColor,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "New Password",
                        suffixIcon: Icon(Icons.visibility_off),
                      ),
                    ),
                    SizedBox(height: 15,),
                    TextFormField(
                      cursorColor: AppColor.primaryColor,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Confirm Password",
                        suffixIcon: Icon(Icons.visibility_off),
                      ),
                    ),
                    SizedBox(height: 15,),
                    AppButton(
                      title: "Continue",
                      height: 55,
                      width: double.infinity,
                      onTap: (){

                      },
                    ),
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: (){},
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
      ),
    );
  }
}
