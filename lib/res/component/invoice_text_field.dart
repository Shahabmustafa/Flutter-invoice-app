import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/colors/app_colors.dart';

class InvoiceTextField extends StatelessWidget {
  InvoiceTextField({
    Key? key,
    required this.title,
    this.controller,
    this.suffixIcon,
    this.validator,
    this.prefixIcon,
    this.keyboardType,
    this.enabled = true,
    this.maxLines,
    this.obscureText = false,
  }) : super(key: key);
  String title;
  TextEditingController? controller;
  Widget? suffixIcon;
  Widget? prefixIcon;
  TextInputType? keyboardType;
  String? Function(String?)? validator;
  bool enabled;
  int? maxLines;
  bool obscureText = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 3,),
              Text(
                "*",
                style: TextStyle(
                  color: AppColor.errorColor,
                  fontSize: 16
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Center(
            child: TextFormField(
              obscureText: obscureText,
              controller: controller,
              keyboardType: keyboardType,
              validator: validator,
              enabled: enabled,
              // maxLines: maxLines,
              decoration: InputDecoration(
                fillColor: Colors.grey.shade200,
                filled: true,
                border: InputBorder.none,
                suffixIcon: suffixIcon,
                prefixIcon: prefixIcon,
              ),
              onTapOutside: (event){
                FocusManager.instance.primaryFocus?.unfocus();
              },
            ),
          ),
        ],
      ),
    );
  }
}
