import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/colors/app_colors.dart';
import 'package:flutter_invoice_app/res/component/image_convert_to_icons.dart';

import '../bottam navigator bar/setting/setting.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 0;

  List PageIndex = [
    Text("Home"),
    Text("Static"),
    SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PageIndex[pageIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColor.primaryColor,
        selectedItemColor: AppColor.whiteColor,
        unselectedItemColor: AppColor.whiteColor,
        type: BottomNavigationBarType.fixed,
        currentIndex: pageIndex,
        onTap: (index){
          setState(() {
            pageIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined,color: Colors.white,),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: IconWidget(imageUrl: "assets/images/bottom/svg.png",color: AppColor.whiteColor,),
            label: "Sales",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Setting",
          ),
        ],
      ),
    );
  }
}
