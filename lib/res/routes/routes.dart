import 'package:flutter_invoice_app/view/auth/login_screen.dart';
import 'package:flutter_invoice_app/view/auth/sign_up_screen.dart';
import 'package:flutter_invoice_app/view/home/invoice/add_payer.dart';
import 'package:flutter_invoice_app/view/home/invoice/item_list.dart';
import 'package:flutter_invoice_app/view/home/invoice/list_of_invoice.dart';
import 'package:flutter_invoice_app/view/home/invoice/signature_screen.dart';
import 'package:flutter_invoice_app/view/home/invoice/your_details.dart';
import 'package:flutter_invoice_app/view/home/list_invoice.dart';
import 'package:flutter_invoice_app/view/splash/splash_screen.dart';
import 'package:get/get.dart';

class AppRoutes{

  static const String splashScreen = "/splash_screen";
  static const String loginScreen = "/login_screen";
  static const String signUp = "/signup_screen";
  static const String listInvoice = "/list_invoice";
  static const String listofInvoice = "/list_of_invoice";
  static const String yourDetails = "/your_details";
  static const String addPayer = "/add_payer";
  static const String itemList = "/item_list";
  static const String signature = "/signature_screen";

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
  ];
}