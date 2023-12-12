import 'package:flutter_invoice_app/view/auth/login_screen.dart';
import 'package:flutter_invoice_app/view/auth/sign_up_screen.dart';
import 'package:flutter_invoice_app/view/home/invoice/add_payer.dart';
import 'package:flutter_invoice_app/view/home/invoice/item_list.dart';
import 'package:flutter_invoice_app/view/home/invoice/list_of_invoice.dart';
import 'package:flutter_invoice_app/view/home/invoice/signature_screen.dart';
import 'package:flutter_invoice_app/view/home/invoice/user_profile/setting/languages_change.dart';
import 'package:flutter_invoice_app/view/home/invoice/user_profile/setting/setting.dart';
import 'package:flutter_invoice_app/view/home/invoice/user_profile/user_profile.dart';
import 'package:flutter_invoice_app/view/home/invoice/your_details.dart';
import 'package:flutter_invoice_app/view/home/invoice_detail.dart';
import 'package:flutter_invoice_app/view/home/list_invoice.dart';
import 'package:flutter_invoice_app/view/splash/splash_screen.dart';
import 'package:get/get.dart';

class AppRoutes{

  static const String splashScreen = "/splash_routes";
  static const String loginScreen = "/login_routes";
  static const String signUp = "/signup_routes";
  static const String listInvoice = "/list_routes";
  static const String listofInvoice = "/list_of_invoice_routes";
  static const String yourDetails = "/your_details_routes";
  static const String addPayer = "/add_payer_routes";
  static const String itemList = "/item_list_routes";
  static const String signature = "/signature_routes";
  static const String userProfile = "/user_profile_routes";
  static const String setting = "/setting_routes";
  static const String changeLanguage = "/change_languages_routes";

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
      name: listofInvoice,
      page: () => ListOfInvoice(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(microseconds: 250),
    ),
    GetPage(
      name: yourDetails,
      page: () => YourDetails(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(microseconds: 250),
    ),
    GetPage(
      name: addPayer,
      page: () => AddPayer(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(microseconds: 250),
    ),
    GetPage(
      name: itemList,
      page: () => ItemList(),
      transition: Transition.rightToLeftWithFade,
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
  ];
}