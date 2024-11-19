import 'package:flutter_invoice_app/view/auth/login_screen.dart';
import 'package:flutter_invoice_app/view/auth/sign_up_screen.dart';
import 'package:flutter_invoice_app/view/bottam%20navigator%20bar/setting/category/category_screen.dart';
import 'package:flutter_invoice_app/view/bottam%20navigator%20bar/setting/installment/customer_installment_screen.dart';
import 'package:flutter_invoice_app/view/bottam%20navigator%20bar/setting/installment/supplier_installment_screen.dart';
import 'package:flutter_invoice_app/view/bottam%20navigator%20bar/setting/items/edit_item.dart';
import 'package:flutter_invoice_app/view/bottam%20navigator%20bar/setting/order/edit_order.dart';
import 'package:flutter_invoice_app/view/bottam%20navigator%20bar/setting/order/order_details.dart';
import 'package:flutter_invoice_app/view/bottam%20navigator%20bar/setting/profile/change_password_screen.dart';
import 'package:flutter_invoice_app/view/bottam%20navigator%20bar/setting/supplier/edit_supplier.dart';
import 'package:flutter_invoice_app/view/home/home_screen.dart';
import 'package:flutter_invoice_app/view/splash/splash_screen.dart';
import 'package:get/get.dart';
import '../../view/bottam navigator bar/setting/change_profile_detail.dart';
import '../../view/bottam navigator bar/setting/customer/add_customer.dart';
import '../../view/bottam navigator bar/setting/customer/customer_detail.dart';
import '../../view/bottam navigator bar/setting/customer/customer_screen.dart';
import '../../view/bottam navigator bar/setting/items/add_item.dart';
import '../../view/bottam navigator bar/setting/items/item_detail.dart';
import '../../view/bottam navigator bar/setting/items/item_screen.dart';
import '../../view/bottam navigator bar/setting/languages_change.dart';
import '../../view/bottam navigator bar/setting/order/add_order.dart';
import '../../view/bottam navigator bar/setting/order/order.dart';
import '../../view/bottam navigator bar/setting/profile/profile_screen.dart';
import '../../view/bottam navigator bar/setting/setting.dart';
import '../../view/bottam navigator bar/setting/supplier/add_supplier.dart';
import '../../view/bottam navigator bar/setting/supplier/supplier.dart';
import '../../view/bottam navigator bar/setting/supplier/supplier_detail.dart';

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
  static const String homeScreen = "/home_screen";
  static const String addItems = "/add_items";
  static const String editItem = "/editItem_screen";
  static const String Items = "/items_screen";
  static const String itemDetail = "/itemDetail_screen";
  static const String addSupplier = "/add_supplier";
  static const String Supplier = "/supplier_screen";
  static const String SupplierDetails = "/supplierDetail_screen";
  static const String editSupplier = "/editSupplier_screen";
  static const String addCustomer = "/add_customer";
  static const String Customer = "/customer_screen";
  static const String CustomersDetail = "/CustomerDetail_screen";
  static const String addOrder = "/add_order";
  static const String Order = "/order_screen";
  static const String orderDetail = "/orderDetail_screen";
  static const String editOrder = "/editOrder_screen";
  static const String categoryScreen = "/category_screen";
  static const String changePasswordScreen = "/change_password_screen";
  static const String customerInstallmentScreen = "/customer_installment_screen";
  static const String supplierInstallmentScreen = "/supplier_installment_screen";

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
      name: homeScreen,
      page: () => HomePage(),
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
      name: addItems,
      page: () => AddItems(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(microseconds: 250),
    ),
    GetPage(
      name: Items,
      page: () => ItemScreen(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(microseconds: 250),
    ),
    GetPage(
      name: editItem,
      page: () => EditItem(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(microseconds: 250),
    ),
    GetPage(
      name: itemDetail,
      page: () => ItemDetail(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(microseconds: 250),
    ),
    GetPage(
      name: addSupplier,
      page: () => AddSupplier(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(microseconds: 250),
    ),
    GetPage(
      name: Supplier,
      page: () => SupplierScreen(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(microseconds: 250),
    ),
    GetPage(
      name: SupplierDetails,
      page: () => SupplierDetail(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(microseconds: 250),
    ),
    GetPage(
      name: editSupplier,
      page: () => EditSupplier(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(microseconds: 250),
    ),
    GetPage(
      name: addCustomer,
      page: () => AddCustomer(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(microseconds: 250),
    ),
    GetPage(
      name: Customer,
      page: () => CustomerScreen(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(microseconds: 250),
    ),
    GetPage(
      name: CustomersDetail,
      page: () => CustomerDetail(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(microseconds: 250),
    ),
    GetPage(
      name: addOrder,
      page: () => AddOrder(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(microseconds: 250),
    ),
    GetPage(
      name: Order,
      page: () => OrderScreen(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(microseconds: 250),
    ),
    GetPage(
      name: editOrder,
      page: () => EditOrder(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(microseconds: 250),
    ),
    GetPage(
      name: orderDetail,
      page: () => OrderDetail(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(microseconds: 250),
    ),
    GetPage(
      name: categoryScreen,
      page: () => CategoryScreen(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(microseconds: 250),
    ),
    GetPage(
      name: changePasswordScreen,
      page: () => ChangePasswordScreen(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(microseconds: 250),
    ),

    GetPage(
      name: customerInstallmentScreen,
      page: () => CustomerInstallmentScreen(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(microseconds: 250),
    ),

    GetPage(
      name: supplierInstallmentScreen,
      page: () => SupplierInstallmentScreen(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(microseconds: 250),
    ),
  ];
}