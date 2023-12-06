import 'package:flutter_invoice_app/res/colors/app_colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils{
  static flutterToast(String message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColor.whiteColor,
        textColor: AppColor.blackColor,
        fontSize: 16.0
    );
  }
}