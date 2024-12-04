import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_invoice_app/model/user_model.dart';
import 'package:flutter_invoice_app/res/app_api/app_api_service.dart';
import 'package:flutter_invoice_app/res/routes/routes.dart';
import 'package:flutter_invoice_app/view%20model/auth%20service/signup_service.dart';
import 'package:get/get.dart';

class UserService extends GetxController{

  static final signupService = Get.put(SignUpService());
  static var date = DateTime.now();
  static var specificId = date.millisecondsSinceEpoch;
  // static final notification = NotificationService();



  static userAddDataFirestore(String userName,String email,password){
    signupService.setLoading(true);
    try{
      UserModel userModel = UserModel(
        uid: FirebaseAuth.instance.currentUser!.uid,
        userName: userName,
        email: email,
        profileImage: "https://i.pinimg.com/474x/ad/73/1c/ad731cd0da0641bb16090f25778ef0fd.jpg",
        phoneNumber: "xxxx-xxxxxxx",
        cashInHand: 0,
        password: password,
      );
      AppApiService.firestore.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).set(userModel.toJson()).then((value)async{
            Get.toNamed(AppRoutes.homeScreen);
            signupService.setLoading(false);
      }).onError((error, stackTrace){
        signupService.setLoading(false);
      });
    }catch(e){
      signupService.setLoading(false);
      print(e);
    }
  }
}