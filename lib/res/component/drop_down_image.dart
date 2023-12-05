import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/colors/app_colors.dart';

class DropDownImage extends StatelessWidget {
  DropDownImage({Key? key,required this.onTap}) : super(key: key);
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: size.height * 0.17,
        width: size.width * 0.5,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColor.primaryColor,
            width: 2
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add,size: 30,color: AppColor.primaryColor,),
            Text(
              "Add your Logo",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: AppColor.primaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
