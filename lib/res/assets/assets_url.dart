import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AssetsUrl{

  /// dashboard
  static const String appLogo = "assets/images/invoice.png";
  static const String gmailLogo = "assets/images/google.png";
  static const String appleLogo = "assets/images/apple-logo.png";
  static const String addFile = "assets/images/add-file.png";
  static const String closeIcon = "assets/images/close.png";
  static const String cashSale = 'assets/images/svg/cash_sale.svg';
  static const String creditCard = 'assets/images/svg/credit_card.svg';
  static const String creditSale = 'assets/images/svg/credit_sale.svg';
  static const String supplierSale = 'assets/images/svg/supplier.svg';
  static const String totalInstallment = 'assets/images/svg/installment.svg';
  static const String totalSale = 'assets/images/svg/total_sale.svg';

  /// setting
  static const String addItem = 'assets/images/setting/add_item.svg';
  static const String category = 'assets/images/setting/category.svg';
  static const String customer = 'assets/images/setting/customer.svg';
  static const String profile = 'assets/images/setting/profile.svg';
  static const String account = 'assets/images/setting/account.svg';
  static const String changeLanguage = 'assets/images/setting/change_language.svg';
  static const String customerInstallment = 'assets/images/setting/customer_installment.svg';
  static const String darkMode = 'assets/images/setting/dark_mode.svg';
  static const String logout = 'assets/images/setting/logout.svg';
  static const String order = 'assets/images/setting/order.svg';
  static const String supplier = 'assets/images/setting/supplier.svg';
  static const String supplierInstallment = 'assets/images/setting/supplier_installment.svg';
  /// change password
  static const String changePassword = 'assets/images/setting/change_password.svg';
  static const String changePasswordHeadIcon = 'assets/images/setting/change_password_head_icon.svg';
  static const String categoryEdit = 'assets/images/category_edit.svg';

  /// bottom navigation bar
  static const String bottomNavBarDashboardIcon = 'assets/images/bottom_navigation_bar/dashboard.svg';
  static const String bottomNavBarSaleIcon = 'assets/images/bottom_navigation_bar/sale.svg';
  static const String bottomNavBarSettingIcon = 'assets/images/bottom_navigation_bar/setting.svg';

  /// dashboard icons
  static Widget cashSaleSvgIcon = SvgPicture.asset(
    cashSale,
    colorFilter: ColorFilter.mode(Color(0xFF007AD0), BlendMode.srcIn),
    semanticsLabel: 'cashSale',
    height: 30,
    width: 30,
  );

  static Widget creditCardSvgIcon = SvgPicture.asset(
    creditCard,
    colorFilter: ColorFilter.mode(Color(0xFFB552F8), BlendMode.srcIn),
    semanticsLabel: 'creditCard',
    height: 30,
    width: 30,
  );

  static Widget creditSaleSvgIcon = SvgPicture.asset(
    creditSale,
    colorFilter: ColorFilter.mode(Color(0xFF1F9C33), BlendMode.srcIn),
    semanticsLabel: 'creditSale',
    height: 30,
    width: 30,
  );

  static Widget supplierSaleSvgIcon = SvgPicture.asset(
    supplierSale,
    colorFilter: ColorFilter.mode(Color(0xFFF79F1A), BlendMode.srcIn),
    semanticsLabel: 'supplierSale',
    height: 30,
    width: 30,
  );

  static Widget totalInstallmentSvgIcon = SvgPicture.asset(
    totalInstallment,
    colorFilter: ColorFilter.mode(Color(0xFFF44236), BlendMode.srcIn),
    semanticsLabel: 'totalInstallment',
    height: 30,
    width: 30,
  );

  static Widget totalSaleSvgIcon = SvgPicture.asset(
    totalSale,
    colorFilter: ColorFilter.mode(Color(0xFF27C9DF), BlendMode.srcIn),
    semanticsLabel: 'totalSale',
    height: 30,
    width: 30,
  );

  /// setting icons
  static Widget addItemSvgIcon = SvgPicture.asset(
    addItem,
    semanticsLabel: 'addItem',
    height: 30,
    width: 30,
  );

  static Widget categorySvgIcon = SvgPicture.asset(
    category,
    semanticsLabel: 'category',
    height: 30,
    width: 30,
  );

  static Widget customerSvgIcon = SvgPicture.asset(
    customer,
    semanticsLabel: 'customer',
    height: 30,
    width: 30,
  );

  static Widget profileSvgIcon = SvgPicture.asset(
    profile,
    semanticsLabel: 'profile',
    height: 30,
    width: 30,
  );

  static Widget accountSvgIcon = SvgPicture.asset(
    account,
    semanticsLabel: 'account',
    height: 30,
    width: 30,
  );

  static Widget changeLanguageSvgIcon = SvgPicture.asset(
    changeLanguage,
    semanticsLabel: 'changeLanguage',
    height: 30,
    width: 30,
  );

  static Widget customerInstallmentSvgIcon = SvgPicture.asset(
    customerInstallment,
    semanticsLabel: 'customerInstallment',
    height: 30,
    width: 30,
  );

  static Widget darkModeSvgIcon = SvgPicture.asset(
    darkMode,
    semanticsLabel: 'darkMode',
    height: 30,
    width: 30,
  );

  static Widget logoutSvgIcon = SvgPicture.asset(
    logout,
    semanticsLabel: 'logout',
    height: 30,
    width: 30,
  );

  static Widget orderSvgIcon = SvgPicture.asset(
    order,
    semanticsLabel: 'order',
    height: 30,
    width: 30,
  );

  static Widget supplierSvgIcon = SvgPicture.asset(
    supplier,
    semanticsLabel: 'supplier',
    height: 30,
    width: 30,
  );

  static Widget supplierInstallmentSvgIcon = SvgPicture.asset(
    supplierInstallment,
    semanticsLabel: 'supplierInstallment',
    height: 30,
    width: 30,
  );


  /// change password icon
  static Widget changePasswordSvgIcon = SvgPicture.asset(
    changePassword,
    semanticsLabel: 'changePassword',
    height: 30,
    width: 30,
  );

  static Widget changePasswordHeadIconSvgIcon = SvgPicture.asset(
    changePasswordHeadIcon,
    semanticsLabel: 'changePasswordHeadIcon',
    height: 80,
    width: 80,
  );

  static Widget categoryEditSvgIcon = SvgPicture.asset(
    categoryEdit,
    semanticsLabel: 'categoryEdit',
    height: 22,
    width: 22,
  );

  /// bottom navigation bar

  static Widget bottomNavBarDashboardSvgIcon = SvgPicture.asset(
    bottomNavBarDashboardIcon,
    semanticsLabel: 'bottomNavBarDashboardIcon',
    height: 22,
    width: 22,
  );

  static Widget bottomNavBarSaleSvgIcon = SvgPicture.asset(
    bottomNavBarSaleIcon,
    semanticsLabel: 'bottomNavBarSaleIcon',
    height: 22,
    width: 22,
  );

  static Widget bottomNavBarSettingSvgIcon = SvgPicture.asset(
    bottomNavBarSettingIcon,
    semanticsLabel: 'bottomNavBarSettingIcon',
    height: 22,
    width: 22,
  );

}