import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/colors/app_colors.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../view model/image_picker/image_picker_service.dart';

class DropDownImage extends StatelessWidget {
  DropDownImage({Key? key}) : super(key: key);
  final pickImage = Get.put(ImagePickerService());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: (){
        pickImage.getImage(
          context,
          ImageSource.gallery,
        );
      },
      child: Obx(() =>
          Container(
            height: size.height * 0.17,
            width: size.width * 0.5,
            decoration: BoxDecoration(
              border: Border.all(
                  color: AppColor.primaryColor,
                  width: 2
              ),
            ),
            child: pickImage.imagePath.isEmpty ?
            Column(
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
            ) :
            Image.file(
              File(
                pickImage.imagePath.toString(),
              ),
              fit: BoxFit.fill,
            ),
          ),
      ),
    );
  }
}
