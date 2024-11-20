import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/routes/routes.dart';
import 'package:get/get.dart';

class OrderInvoiceScreen extends StatefulWidget {
  const OrderInvoiceScreen({Key? key}) : super(key: key);

  @override
  State<OrderInvoiceScreen> createState() => _OrderInvoiceScreenState();
}

class _OrderInvoiceScreenState extends State<OrderInvoiceScreen> {

  var itemData = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Invoice"),
      ),
      body: Column(
        children: [
          
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.toNamed(AppRoutes.orderScreen);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
