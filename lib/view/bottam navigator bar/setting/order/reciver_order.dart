


import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/calculation/calculation.dart';
import 'package:get/get.dart';

import '../../../../res/app_api/app_api_service.dart';
import '../../../../res/routes/routes.dart';

class OrderReceiver extends StatefulWidget {
  const OrderReceiver({Key? key}) : super(key: key);

  @override
  State<OrderReceiver> createState() => _OrderReceiverState();
}

class _OrderReceiverState extends State<OrderReceiver> {

  final receiverOrder = AppApiService.order.where("type",isEqualTo: "Receiver").snapshots();
  final multiply = Calculation();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: receiverOrder,
      builder: (context,snapshot){
        if(snapshot.hasData){
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context,index){
              var order = snapshot.data!.docs[index];
              return Card(
                child: ListTile(
                  title: Text(order["itemName"]),
                  subtitle: Text(order["date"]),
                  trailing: Text("Stock ${order["Stock"]}"),
                  onTap: (){
                    Get.toNamed(
                      AppRoutes.orderDetail,
                      arguments: [
                        order["itemName"],
                        order["companyName"],
                        order["sale"],
                        order["cost"],
                        order["wholeSale"],
                        order["discount"],
                        order["Tax"],
                        order["Stock"],
                        order["type"],
                        snapshot.data!.docs[index].id,
                      ],
                    );
                  },
                ),
              );
            },
          );
        }else{
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
