import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/app_api/app_api_service.dart';
import 'package:flutter_invoice_app/view%20model/firebase/item_controller.dart';
import 'package:get/get.dart';

import '../../../view model/firebase/order_controller.dart';

class SalesPage extends StatefulWidget {
  const SalesPage({Key? key}) : super(key: key);

  @override
  State<SalesPage> createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sale"),
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder(
        stream: AppApiService.item.snapshots(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context,index){
                var data = snapshot.data!.docs[index];
                return Card(
                  child: ListTile(
                    title: Text(data["itemName"]),
                    subtitle: Text(data["sale"]),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: (){
                            setState(() {
                               data.id;
                            });
                            count++;
                          },
                          child: Icon(
                            Icons.add,
                            size: 20,
                          ),
                        ),
                        Text(
                          count.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            setState(() {
                              count--;
                            });
                          },
                          child: Icon(
                            Icons.minimize,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }else{
            return Center(child: CircularProgressIndicator());
          }
        },
      )
    );
  }
}
