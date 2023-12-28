import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/colors/app_colors.dart';

class ChangeLanguages extends StatefulWidget {
  const ChangeLanguages({Key? key}) : super(key: key);

  @override
  State<ChangeLanguages> createState() => _ChangeLanguagesState();
}

class _ChangeLanguagesState extends State<ChangeLanguages> {

  String _radioValue = 'English';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Languages"),
      ),
      body: Column(
        children: [
          Card(
            child: ListTile(
              title: Text("English"),
              trailing: Radio(
                value: "English",
                groupValue: _radioValue,
                activeColor: AppColor.primaryColor,
                onChanged: (value){
                  setState(() {
                    _radioValue = value!;
                  });
                },
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: Text("Urdu"),
              trailing: Radio(
                value: "Urdu",
                groupValue: _radioValue,
                activeColor: AppColor.primaryColor,
                onChanged: (value){
                  setState(() {
                    _radioValue = value!;
                  });
                },
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: Text("Chines"),
              trailing: Radio(
                value: "Chines",
                groupValue: _radioValue,
                activeColor: AppColor.primaryColor,
                onChanged: (value){
                  setState(() {
                    _radioValue = value!;
                  });
                },
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: Text("Arabic"),
              trailing: Radio(
                value: "Arabic",
                groupValue: _radioValue,
                activeColor: AppColor.primaryColor,
                onChanged: (value){
                  setState(() {
                    _radioValue = value!;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
