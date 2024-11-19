import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/routes/routes.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../res/app_api/app_api_service.dart';
import '../../../../res/assets/assets_url.dart';
import '../../../../res/colors/app_colors.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({Key? key}) : super(key: key);

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  bool search = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: search ?
        TextField(
          cursorHeight: 18,
          cursorColor: AppColor.whiteColor,
          style: GoogleFonts.lato(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColor.whiteColor,
          ),
          decoration: InputDecoration(
            hintText: "Customer Name",
            hintStyle: GoogleFonts.lato(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColor.whiteColor,
            ),
            border: InputBorder.none,
          ),
        ) :
        Text("Customer"),
        actions: [
          IconButton(
            onPressed: (){
              if(search == false){
                search = true;
                setState(() {

                });
              }else{
                search = false;
                setState(() {

                });
              }
            },
            icon: Icon(CupertinoIcons.search),
          )
        ],
      ),
      body: StreamBuilder(
        stream: AppApiService.customer.snapshots(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context,index){
                var customer = snapshot.data!.docs[index];
                customerPayment() {
                  List<dynamic> supplierPayment = customer["payment"];
                  int sum = 0;
                  for (String amount in supplierPayment) {
                    sum += int.tryParse(amount) ?? 0; // Parse string to int, default to 0 if parsing fails
                  }
                  return sum;
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 7.5),
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: AppColor.whiteColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 0.8,
                          color: Colors.grey,
                          offset: Offset(0.3, 0.2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(customer["customerName"],style: GoogleFonts.lato(fontWeight: FontWeight.w600,fontSize: 16),),
                        Row(
                          children: [
                            IconButton(
                              onPressed: (){
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
                              icon: AssetsUrl.categoryEditSvgIcon,
                            ),
                            IconButton(
                              onPressed: (){
                                AppApiService.item.doc(customer.id).delete();
                              },
                              icon: Icon(CupertinoIcons.delete,size: 22,color: AppColor.errorColor,),
                            ),
                          ],
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
