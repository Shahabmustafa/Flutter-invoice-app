import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/colors/app_colors.dart';
import 'package:flutter_invoice_app/utils/utils.dart';

class AppButton extends StatelessWidget {
  AppButton({Key? key,required this.title,this.height,this.onTap,this.width,this.loading = false,this.color,this.textColor}) : super(key: key);
  String title;
  VoidCallback? onTap;
  double? height;
  double? width;
  bool loading = false;
  Color? color;
  Color? textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: loading ? null : onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          // ignore: unnecessary_null_comparison
          color: color != null ? color : Theme.of(context).splashColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColor.primaryColor,
          ),
        ),
        child: loading ? Center(child: Utils.circularForButton) : Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: textColor ?? AppColor.whiteColor,
              ),
            ),
        ),
      ),
    );
  }
}
