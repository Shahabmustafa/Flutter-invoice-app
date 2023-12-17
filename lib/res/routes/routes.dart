import 'package:flutter_invoice_app/view/auth/login_screen.dart';
import 'package:flutter_invoice_app/view/auth/sign_up_screen.dart';
import 'package:flutter_invoice_app/view/home/invoice/item/add_item.dart';
import 'package:flutter_invoice_app/view/home/invoice/signature_screen.dart';
import 'package:flutter_invoice_app/view/home/invoice/user_profile/setting/change_profile_detail.dart';
import 'package:flutter_invoice_app/view/home/invoice/user_profile/setting/languages_change.dart';
import 'package:flutter_invoice_app/view/home/invoice/user_profile/setting/setting.dart';
import 'package:flutter_invoice_app/view/home/invoice/user_profile/user_profile.dart';
import 'package:flutter_invoice_app/view/home/list_invoice.dart';
import 'package:flutter_invoice_app/view/splash/splash_screen.dart';
import 'package:get/get.dart';

class AppRoutes{

  static const String splashScreen = "/splash_routes";
  static const String loginScreen = "/login_routes";
  static const String signUp = "/signup_routes";
  static const String listInvoice = "/list_routes";
  static const String addPayer = "/add_payer_routes";
  static const String addItem = "/add_item";
  static const String signature = "/signature_routes";
  static const String userProfile = "/user_profile_routes";
  static const String setting = "/setting_routes";
  static const String changeLanguage = "/change_languages_routes";
  static const String changeProfileDetail = "/change_profile_detail";

  static appRoutes() => [
    GetPage(
      name: splashScreen,
      page: () => SplashPage(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(microseconds: 250),
    ),
    GetPage(
      name: loginScreen,
      page: () => LoginPage(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(microseconds: 250),
    ),
    GetPage(
      name: signUp,
      page: () => SignUpPage(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(microseconds: 250),
    ),
    GetPage(
      name: listInvoice,
      page: () => ListInvoice(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(microseconds: 250),
    ),
    GetPage(
      name: signature,
      page: () => SignaturePage(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(microseconds: 250),
    ),
    GetPage(
      name: userProfile,
      page: () => UserProfile(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(microseconds: 250),
    ),
    GetPage(
      name: setting,
      page: () => SettingPage(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(microseconds: 250),
    ),
    GetPage(
      name: changeLanguage,
      page: () => ChangeLanguages(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(microseconds: 250),
    ),
    GetPage(
      name: changeProfileDetail,
      page: () => ChangeProfileDetail(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(microseconds: 250),
    ),
    GetPage(
      name: addItem,
      page: () => AddItem(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(microseconds: 250),
    ),
  ];
}