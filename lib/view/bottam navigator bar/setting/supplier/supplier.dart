import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/routes/routes.dart';
import 'package:get/get.dart';

import '../../../../res/app_api/app_api_service.dart';

class SupplierScreen extends StatefulWidget {
  const SupplierScreen({Key? key}) : super(key: key);

  @override
  State<SupplierScreen> createState() => _SupplierScreenState();
}

class _SupplierScreenState extends State<SupplierScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Supplier"),
      ),
      body: StreamBuilder(
        stream: AppApiService.supplier.snapshots(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context,index){
                var supplier = snapshot.data!.docs[index];
                supplierPayment() {
                  List<dynamic> supplierPayment = supplier["payment"];
                  int sum = 0;
                  for (String amount in supplierPayment) {
                    sum += int.tryParse(amount) ?? 0; // Parse string to int, default to 0 if parsing fails
                  }
                  return sum;
                }
                return Card(
                  child: ListTile(
                    title: Text(supplier["companyName"]),
                    subtitle: Text(supplier["supplierName"]),
                    trailing: Text("${supplierPayment()}"),
                    onTap: (){
                      Get.toNamed(
                        AppRoutes.SupplierDetails,
                        arguments: [
                          supplier["companyName"],
                          supplier["companyEmail"],
                          supplier["phoneNumber"],
                          supplier["address"],
                          supplier["supplierName"],
                          supplier["supplierPhoneNumber"],
                          supplier["supplierEmail"],
                          supplier["payment"],
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.toNamed(AppRoutes.addSupplier);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
