import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/assets/assets_url.dart';
import 'package:flutter_invoice_app/view/bottam%20navigator%20bar/dashboard/dashboard_screen.dart';
import 'package:flutter_invoice_app/view/bottam%20navigator%20bar/sales/sale_invoice_screen.dart';

import '../bottam navigator bar/setting/setting.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 0;

  List PageIndex = [
    DashboardScreen(),
    SaleInvoiceScreen(),
    SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PageIndex[pageIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        onTap: (index){
          setState(() {
            pageIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: AssetsUrl.bottomNavBarDashboardSvgIcon,
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: AssetsUrl.bottomNavBarSaleSvgIcon,
            label: "Sales",
          ),
          BottomNavigationBarItem(
            icon: AssetsUrl.bottomNavBarSettingSvgIcon,
            label: "Setting",
          ),
        ],
      ),
    );
  }
}
