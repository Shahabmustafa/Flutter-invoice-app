import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/component/app_button.dart';
import 'package:flutter_invoice_app/res/component/invoice_text_field.dart';
import 'package:flutter_invoice_app/res/routes/routes.dart';
import 'package:flutter_invoice_app/view%20model/invoice%20service/inoice_service.dart';
import 'package:get/get.dart';
import '../../../../res/component/drop_down_image.dart';

class CustomerDetail extends StatefulWidget {
  const CustomerDetail({Key? key}) : super(key: key);

  @override
  State<CustomerDetail> createState() => _CustomerDetailState();
}

class _CustomerDetailState extends State<CustomerDetail> {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("New Customer"),
      ),
      body: SingleChildScrollView(
        // child:
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
