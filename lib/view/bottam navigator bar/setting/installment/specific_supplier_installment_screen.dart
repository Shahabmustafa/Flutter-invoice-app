import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SpecificSupplierInstallmentScreen extends StatefulWidget {
  SpecificSupplierInstallmentScreen({super.key, this.supplierID, this.supplierName});
  final String? supplierID;
  final String? supplierName;
  @override
  State<SpecificSupplierInstallmentScreen> createState() => _SpecificSupplierInstallmentScreenState();
}

class _SpecificSupplierInstallmentScreenState extends State<SpecificSupplierInstallmentScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.supplierName} Supplier"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("users").
        doc(FirebaseAuth.instance.currentUser!.uid).
        collection("supplierInstallment").orderBy("date",descending: true).where("supplierId",isEqualTo: widget.supplierID).
        snapshots(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context,index){
                DateTime dateTime = snapshot.data!.docs[index]["date"].toDate();
                String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  child: Card(
                    child: ListTile(
                      title: Text(snapshot.data!.docs[index]["supplierName"]),
                      subtitle: Text(formattedDate),
                      trailing: Text(snapshot.data!.docs[index]["payBalance"]),
                    ),
                  ),
                );
              },
            );
          }else{
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

