import 'package:get/get.dart';

class Languages extends Translations{
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
    "en_us" : {
      "login_email_hading" : "Email",
      "login_email_validator" : "Please Enter Email",

      "login_password_hading" : "Email",
      "login_password_validator" : "Please Enter password",
      "login_password_second_validator" : "Please Enter Eight Digits code",

      // forgetPassword
      "forget_password" : "Forget Password",

      "don't_have_any_account" : "Don't have any account",
      "sign_up_link" : "Sign Up",

      "signup_email_hading" : "Email",
      "signup_email_validator" : "Please Enter Email",

      "signup_password_hading" : "Email",
      "signup_password_validator" : "Please Enter password",
      "signup_password_second_validator" : "Please Enter Eight Digits code",

      "signup_con_password_hading" : "Email",
      "signup_con_password_validator" : "Please Enter password",
      "signup_con_password_second_validator" : "Please Enter Eight Digits code",


      "already_have_an_account" : "Already have an account",
      "sign_in_link" : "Sign in",
    }
  };
}