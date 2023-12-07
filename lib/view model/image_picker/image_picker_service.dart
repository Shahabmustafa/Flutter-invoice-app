import 'package:flutter/cupertino.dart';
import 'package:flutter_invoice_app/utils/utils.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerService extends GetxController{
  RxString imagePath = "".obs;
  ImagePicker imagePicker = ImagePicker();
  Future getImage(BuildContext context,ImageSource imageSource)async{
    final image = await imagePicker.pickImage(source: imageSource);
    if(image != null){
      imagePath.value = image.path.toString();
    }else{
      Utils.flutterToast("Please Pick Image");
    }
  }

}