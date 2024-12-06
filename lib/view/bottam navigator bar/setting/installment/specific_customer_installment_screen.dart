import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../utils/utils.dart';

class SpecificCustomerInstallmentScreen extends StatefulWidget {
  SpecificCustomerInstallmentScreen({super.key, this.customerID, this.customerName});
  final String? customerID;
  final String? customerName;
  @override
  State<SpecificCustomerInstallmentScreen> createState() => _SpecificCustomerInstallmentScreenState();
}

class _SpecificCustomerInstallmentScreenState extends State<SpecificCustomerInstallmentScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.customerName} Customer"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("users").
        doc(FirebaseAuth.instance.currentUser!.uid).
        collection("customerInstallment").where("customerId",isEqualTo: widget.customerID).
        snapshots(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context,index){
                DateTime dateTime = snapshot.data!.docs[index]["date"].toDate();
                String formattedDate = DateFormat('dd-MM-yyyy hh:mm a').format(dateTime);
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  child: Card(
                    child: ListTile(
                      title: Text(snapshot.data!.docs[index]["customerName"]),
                      subtitle: Text(formattedDate),
                      trailing: Text(snapshot.data!.docs[index]["payBalance"]),
                    ),
                  ),
                );
              },
            );
          }else{
            return Center(child: Utils.circular);
          }
        },
      ),
    );
  }
}

