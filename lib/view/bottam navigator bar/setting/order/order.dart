import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/app_api/app_api_service.dart';
import 'package:flutter_invoice_app/res/routes/routes.dart';
import 'package:flutter_invoice_app/view/bottam%20navigator%20bar/setting/order/reciver_order.dart';
import 'package:flutter_invoice_app/view/bottam%20navigator%20bar/setting/order/sender_order.dart';
import 'package:get/get.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {

  var itemData = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Order"),
          bottom: TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            unselectedLabelColor: Colors.black,
            tabs: [
              Tab(
                text: "Sender",
              ),
              Tab(
                text: "Receiver",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            OrderSender(),
            OrderReceiver(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Get.toNamed(AppRoutes.addOrder);
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
