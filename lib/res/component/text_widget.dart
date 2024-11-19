import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/colors/app_colors.dart';

class TextWidgets extends StatelessWidget {
  TextWidgets({Key? key,required this.title,required this.subtitle}) : super(key: key);
  String title;
  String subtitle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: AppColor.primaryColor,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
