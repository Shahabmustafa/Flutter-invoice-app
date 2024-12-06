

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../utils/utils.dart';

class DashboardHistoryScreen extends StatefulWidget {
  const DashboardHistoryScreen({super.key});

  @override
  State<DashboardHistoryScreen> createState() => _DashboardHistoryScreenState();
}

class _DashboardHistoryScreenState extends State<DashboardHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard History"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("dashboard").orderBy("date",descending: true).snapshots(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context,index){
                return Card(
                  child: ExpansionTile(
                    title: Text("Date"),
                    subtitle: Text(snapshot.data!.docs[index]["date"],style: TextStyle(fontSize: 12,color: Colors.grey),),
                    children: [
                      ListTile(
                        title: Text("Cash Sale"),
                        trailing: Text(snapshot.data!.docs[index]["cashSale"].toString()),
                      ),
                      ListTile(
                        title: Text("Credit Sale"),
                        trailing: Text(snapshot.data!.docs[index]["creditSale"].toString()),
                      ),
                      ListTile(
                        title: Text("Expense"),
                        trailing: Text(snapshot.data!.docs[index]["expense"].toString()),
                      ),
                      ListTile(
                        title: Text("Supplier Payment"),
                        trailing: Text(snapshot.data!.docs[index]["supplierPayment"].toString()),
                      ),
                      ListTile(
                        title: Text("Total Installment"),
                        trailing: Text(snapshot.data!.docs[index]["totalInstallment"].toString()),
                      ),
                      ListTile(
                        title: Text("Total Sale"),
                        trailing: Text((snapshot.data!.docs[index]["cashSale"] + snapshot.data!.docs[index]["creditSale"]).toString()),
                      ),
                    ],
                  )
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
