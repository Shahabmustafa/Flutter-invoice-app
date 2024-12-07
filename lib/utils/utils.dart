import 'package:flutter_invoice_app/res/colors/app_colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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

  static const circular = SpinKitFadingFour(
    color: AppColor.primaryColor,
    size: 50.0,
  );

  static const circularForButton = SpinKitFadingFour(
    color: AppColor.whiteColor,
    size: 25.0,
  );

}