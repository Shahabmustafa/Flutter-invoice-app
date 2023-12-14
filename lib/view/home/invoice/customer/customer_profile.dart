import 'package:flutter/material.dart';

class CustomerProfile extends StatefulWidget {
  const CustomerProfile({Key? key}) : super(key: key);

  @override
  State<CustomerProfile> createState() => _CustomerProfileState();
}

class _CustomerProfileState extends State<CustomerProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Profile"),
      ),
      body: Column(
        children: [
          ListTile(
            leading: Icon(Icons.account_balance),
            title: Text("Customer Account Create"),
            subtitle: Text("18-03-20204"),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Customer Name"),
            subtitle: Text("Shahab Mustafa"),
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text("Customer Email"),
            subtitle: Text("shahabmustafa57@gmail.com"),
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text("Customer Phone"),
            subtitle: Text("03112445554"),
          ),
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text("Customer Address"),
            subtitle: Text("Hussain Town Street No 4"),
          ),
        ],
      ),
    );
  }
}
