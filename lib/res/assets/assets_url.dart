import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AssetsUrl{
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

}