import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/component/image_convert_to_icons.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: (){

              },
              child: Icon(
                Icons.settings,
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
