

import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/app_api/app_api_service.dart';
import 'package:flutter_invoice_app/view/home/invoice/customer/customer_profile.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../res/component/custom_container.dart';
import '../../../../res/routes/routes.dart';

class CustomerList extends StatefulWidget {
  const CustomerList({Key? key}) : super(key: key);

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer List"),
      ),
      body: StreamBuilder(
        stream: AppApiService.firestore
            .collection("users")
            .doc(AppApiService.userId)
            .collection("customer")
            .snapshots(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context,index){
                return CustomerContainer(
                  customerName: snapshot.data!.docs[index]["CustomerName"],
                  customerNumber: snapshot.data!.docs[index]["CustomerPhone"],
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CustomerProfile()));
                  },
                );
              },
            );
          }else{
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.toNamed(AppRoutes.addCustomer);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
