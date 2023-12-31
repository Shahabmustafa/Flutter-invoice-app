import 'package:flutter/material.dart';

class TextWidgets extends StatelessWidget {
  TextWidgets({Key? key,required this.title,required this.subtitle}) : super(key: key);
  String title;
  String subtitle;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
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
    );
  }
}
