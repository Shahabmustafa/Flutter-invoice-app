import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/app_api/app_api_service.dart';
import 'package:flutter_invoice_app/res/colors/app_colors.dart';
import 'package:flutter_invoice_app/utils/utils.dart';
import 'package:get/get.dart';

import '../../../../../view model/swith_service/swith_service.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Column(
        children: [
          Card(
            child: ListTile(
              leading: Icon(Icons.person),
              title: Text("Change Profile Detail"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: (){

              },
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.alternate_email),
              trailing: Icon(Icons.arrow_forward_ios),
              title: Text("Change Email"),
              onTap: (){

              },
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.key),
              title: Text("Change Password"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: (){

              },
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.language),
              title: Text("Change Language"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: (){
                Get.toNamed("/change_languages_routes");
              },
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.dark_mode),
              title: Text("Dark Mode"),
              trailing: GetBuilder<ThemeController>(
                builder: (controller) {
                  return Switch(
                    activeColor: AppColor.primaryColor,
                    value: controller.isDark,
                    onChanged: (value) {
                      controller.changeTheme(value);
                    },
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.exit_to_app_rounded),
              title: Text("Logout"),
              onTap: (){
                AppApiService.auth.signOut().then((value){
                  Get.toNamed("/login_routes");
                  Utils.flutterToast("Log Out");
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
