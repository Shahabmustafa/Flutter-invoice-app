import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_invoice_app/res/colors/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class InvoiceTextField extends StatelessWidget {
  InvoiceTextField({
    Key? key,
    required this.title,
    this.hintText,
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
    this.onlyNumber = false,
    this.onChanged,
  }) : super(key: key);
  String title;
  String? hintText;
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
  bool onlyNumber;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
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
            cursorHeight: 18,
            inputFormatters: onlyNumber ? <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ] : null,
            decoration: InputDecoration(
              hintText: hintText,
              suffix: suffix,
              labelStyle: TextStyle(
                color: Theme.of(context).textTheme.displayLarge!.color,
              ),
              hintStyle: GoogleFonts.lato(
                color: AppColor.blackColor,
                fontWeight: FontWeight.normal,
                fontSize: 14
              ),
              focusColor: AppColor.primaryColor,
              hoverColor: AppColor.primaryColor,
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
    );
  }
}
