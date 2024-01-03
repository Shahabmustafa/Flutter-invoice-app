import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/routes/routes.dart';
import 'package:get/get.dart';

import '../../../../res/app_api/app_api_service.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({Key? key}) : super(key: key);

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer"),
      ),
      body: StreamBuilder(
        stream: AppApiService.customer.snapshots(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context,index){
                var customer = snapshot.data!.docs[index];
                return Card(
                  child: ListTile(
                    title: Text(customer["customerName"]),
                    trailing: Text("${customer["payment"]}"),
                    onTap: (){
                      Get.toNamed(
                          AppRoutes.CustomersDetail,
                          arguments: [
                            customer["customerName"],
                            customer["email"],
                            customer["phoneNumber"],
                            customer["address"],
                            customer["payment"],
                            customer["cnic"],
                            customer["category"],
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
          Get.toNamed(AppRoutes.addCustomer);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
