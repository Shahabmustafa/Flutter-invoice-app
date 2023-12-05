


import 'package:flutter/cupertino.dart';
import 'package:flutter_invoice_app/res/colors/app_colors.dart';

class AppButton extends StatelessWidget {
  AppButton({Key? key,required this.title,this.height,this.onTap,this.width}) : super(key: key);
  String title;
  VoidCallback? onTap;
  double? height;
  double? width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: AppColor.primaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColor.whiteColor,
              ),
            ),
        ),
      ),
    );
  }
}
