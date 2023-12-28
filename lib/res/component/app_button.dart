import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/colors/app_colors.dart';

class AppButton extends StatelessWidget {
  AppButton({Key? key,required this.title,this.height,this.onTap,this.width,this.loading = false,this.color}) : super(key: key);
  String title;
  VoidCallback? onTap;
  double? height;
  double? width;
  bool loading = false;
  Color? color;

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
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Theme.of(context).canvasColor,
          ),
        ),
        child: loading ? Center(child: CircularProgressIndicator(color: Theme.of(context).canvasColor,)) : Center(
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
