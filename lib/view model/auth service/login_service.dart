import 'package:flutter/cupertino.dart';
import 'package:flutter_invoice_app/res/app_api/app_api_service.dart';
import 'package:flutter_invoice_app/res/routes/routes.dart';
import 'package:flutter_invoice_app/utils/utils.dart';
import 'package:get/get.dart';

class LoginService extends GetxController{
  RxBool loading = false.obs;
  Rx<TextEditingController> email = TextEditingController().obs;
  Rx<TextEditingController> password = TextEditingController().obs;

  RxBool visibility = true.obs;

  setLoading(bool value){
    loading.value = value;
  }

  isLogin(BuildContext context){
    setLoading(true);
    try{
      AppApiService.auth.signInWithEmailAndPassword(
        email: email.value.text,
        password: password.value.text,
      ).then((value){
        setLoading(false);
        Get.toNamed(AppRoutes.listInvoice);
        Utils.flutterToast("You have Sucessfully Login");
        email.value.clear();
        password.value.clear();
      }).onError((error, stackTrace){
        setLoading(false);
        Utils.flutterToast("Please Check Your Email and Password");
      });
    }catch(e){
      Utils.flutterToast(e.toString());
      setLoading(false);
    }
  }
}