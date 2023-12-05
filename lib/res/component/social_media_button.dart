

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/colors/app_colors.dart';

import '../assets/assets_url.dart';

class SocialMediaButton extends StatelessWidget {
  SocialMediaButton({Key? key,required this.onTap,required this.imageUrl}) : super(key: key);
  VoidCallback onTap;
  String imageUrl;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              width: 0.3,
              color: AppColor.grayColor,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade400,
                blurRadius: 0.2,
                spreadRadius: 0.8,
                offset: Offset(4, 4)
              ),
            ]
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imageUrl,
                height: 30,
                width: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
