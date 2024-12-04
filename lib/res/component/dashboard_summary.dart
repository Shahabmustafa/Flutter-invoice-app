import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors/app_colors.dart';

class DashboardSummary extends StatelessWidget {
  DashboardSummary({
    required this.imageAssets,
    required this.title,
    required this.subtitle,
    this.width = 190,
    super.key,
  });
  String title;
  String subtitle;
  Widget imageAssets;
  double? width;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 90,
      width: width,
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        boxShadow: [
          BoxShadow(
            color: AppColor.grayColor.withOpacity(0.2),
            blurRadius: 10,
            offset: Offset(0.2, 0.1),
          ),
        ],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          imageAssets,
          // AssetsUrl.cashSaleSvgIcon,
          SizedBox(width: 10,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,style: GoogleFonts.lora(fontSize: 12,fontWeight: FontWeight.bold),),
              Text(subtitle,style: GoogleFonts.lora(fontSize: 12,fontWeight: FontWeight.w400),),
            ],
          ),
        ],
      ),
    );
  }
}
