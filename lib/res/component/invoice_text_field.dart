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
    this.suffix,
    this.maxLength,
    this.onTap,
    this.readOnly = false,
    this.onChanged,
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
  Widget? suffix;
  int? maxLength;
  void Function()? onTap;
  bool readOnly;
  void Function(String)? onChanged;
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
                  color: Theme.of(context).textTheme.displayLarge!.color,
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
              maxLength: maxLength,
              readOnly: readOnly,
              // maxLines: maxLines,
              decoration: InputDecoration(
                suffix: suffix,
                labelStyle: TextStyle(
                  color: Theme.of(context).textTheme.displayLarge!.color,
                ),
                hintStyle: TextStyle(
                  color: Theme.of(context).textTheme.displayLarge!.color,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: AppColor.primaryColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: AppColor.primaryColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                  color: AppColor.primaryColor,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: AppColor.errorColor,
                  ),
                ),
                suffixIcon: suffixIcon,
                prefixIcon: prefixIcon,
              ),
              cursorColor: AppColor.primaryColor,
              style: TextStyle(
                color: Theme.of(context).textTheme.displayLarge!.color,
              ),
              onTapOutside: (event){
                FocusManager.instance.primaryFocus?.unfocus();
              },
              onChanged: onChanged,
              onTap: onTap,
            ),
          ),
        ],
      ),
    );
  }
}
