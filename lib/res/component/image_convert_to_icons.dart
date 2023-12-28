import 'package:flutter/cupertino.dart';
import 'package:flutter_invoice_app/res/colors/app_colors.dart';

class IconWidget extends StatelessWidget {
  IconWidget({Key? key,required this.imageUrl,this.onTap,this.color}) : super(key: key);
  String imageUrl;
  VoidCallback? onTap;
  Color? color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 25,
        width: 25,
        child: Image.asset(imageUrl,color: color,),
      ),
    );
  }
}
