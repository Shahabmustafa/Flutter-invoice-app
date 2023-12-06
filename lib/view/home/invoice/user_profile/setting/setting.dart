import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/colors/app_colors.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
              trailing: Switch(
                value: true,
                onChanged: (bool value){

                },
              )
            ),
          ),
        ],
      ),
    );
  }
}
