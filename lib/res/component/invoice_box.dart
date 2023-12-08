import 'package:flutter/material.dart';

import '../colors/app_colors.dart';
import '../fonts/app_fonts.dart';

class InvoiceBox extends StatelessWidget {
  InvoiceBox({Key? key,required this.title,required this.subtitle,required this.icon,required this.onTap}) : super(key: key);
  IconData icon;
  String title;
  String subtitle;
  VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      height: size.height * 0.1,
      width:  size.width * 1,
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: AppColor.grayColor,
              spreadRadius: 0.3,
              blurRadius: 1,
              offset: Offset(0.2,0.2),
            ),
          ]
      ),
      child: ListTile(
        leading: Icon(icon,size: 30,),
        trailing: Icon(Icons.arrow_forward_ios),
        title: Text(
          title,
          style: AppFonts.mediumText,
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: AppColor.grayColor,
          ),
        ),
        onTap: onTap,
      ),
    );

  }
}
