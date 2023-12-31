import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../res/app_api/app_api_service.dart';
import '../../../../res/calculation/calculation.dart';
import '../../../../res/routes/routes.dart';

class OrderSender extends StatefulWidget {
  const OrderSender({Key? key}) : super(key: key);

  @override
  State<OrderSender> createState() => _OrderSenderState();
}

class _OrderSenderState extends State<OrderSender> {
  final senderOrder = AppApiService.order.where("type",isEqualTo: "Sender").snapshots();
  final multiply = Calculation();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: senderOrder,
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
