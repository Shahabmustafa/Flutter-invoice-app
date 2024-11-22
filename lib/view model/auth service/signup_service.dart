import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_invoice_app/res/app_api/app_api_service.dart';
import 'package:flutter_invoice_app/utils/utils.dart';
import 'package:flutter_invoice_app/view%20model/user_service/user_service.dart';
import 'package:get/get.dart';

class SignUpService extends GetxController{

  Rx<TextEditingController> userName = TextEditingController().obs;
  Rx<TextEditingController> email = TextEditingController().obs;
  Rx<TextEditingController> password = TextEditingController().obs;
  Rx<TextEditingController> conPassword = TextEditingController().obs;
  RxBool loading = false.obs;
  RxBool Visibility = true.obs;
  RxBool confirmVisibility = true.obs;

  // static final notification = NotificationService();


  setLoading(bool value){
    loading.value = value;
  }

  isSignUp(BuildContext context){
    setLoading(true);
    try{
      AppApiService.auth.createUserWithEmailAndPassword(
        email: email.value.text,
        password: password.value.text,
      ).then((value)async{
        setLoading(false);
        UserService.userAddDataFirestore(
          userName.value.text,
          email.value.text,
        );
        Utils.flutterToast("Your account has been create");
        userName.value.clear();
        email.value.clear();
        password.value.clear();
        conPassword.value.clear();
      }).onError((error, stackTrace){
        setLoading(false);
        Utils.flutterToast(error.toString());
      });
    }catch(e){
      setLoading(false);
      Utils.flutterToast(e.toString());
    }
  }
}