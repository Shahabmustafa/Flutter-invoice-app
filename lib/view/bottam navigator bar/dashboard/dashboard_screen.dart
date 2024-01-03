import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/app_api/app_api_service.dart';
import 'package:flutter_invoice_app/res/colors/app_colors.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder(
        stream: AppApiService.dashboard.snapshots(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            Map<String, dynamic>? data = snapshot.data!.data() as Map<String,dynamic>;
            supplierPayment() {
              List<dynamic> supplierPayment = data["supplierPayment"];
              int sum = 0;
              for (String amount in supplierPayment) {
                sum += int.tryParse(amount) ?? 0; // Parse string to int, default to 0 if parsing fails
              }
              return sum;
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              child: Container(
                height: size.height * 0.25,
                width: size.width * 1,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Cash Sale Amount",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          "0",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                    Divider(color: AppColor.primaryColor,),
                    Row(
                      children: [
                        Text(
                          "Credit Sale",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          "0",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                    Divider(color: AppColor.primaryColor,),
                    Row(
                      children: [
                        Text(
                          "Total Sale Amount",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          "0",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                    Divider(color: AppColor.primaryColor,),
                    Row(
                      children: [
                        Text(
                          "Total Installment",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          "0",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                    Divider(color: AppColor.primaryColor,),
                    Row(
                      children: [
                        Text(
                          "Supplier Payment",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          "${supplierPayment()}",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ]
                ),
              ),
            );
          }else{
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      // Column(
      //   children: [
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: Container(
      //         height: size.height * 0.5,
      //         width: size.width * 1,
      //         child: StreamBuilder(
      //           stream: AppApiService.order.snapshots(),
      //           builder: (context,snapshot){
      //             if(snapshot.hasData){
      //               return ListView.builder(
      //                 itemCount: snapshot.data!.docs.length,
      //                 itemBuilder: (context,index){
      //                   return AspectRatio(
      //                     aspectRatio: 1,
      //                     child: DChartBarO(
      //                       animate: true,
      //                       configRenderBar: ConfigRenderBar(
      //                           maxBarWidthPx: 50,
      //                           minBarLengthPx: 100
      //                       ),
      //                       animationDuration: Duration(seconds: 3),
      //                       groupList: [
      //                         OrdinalGroup(
      //                             id: "ssss",
      //                             chartType: ChartType.line,
      //                             data: [
      //                               OrdinalData(
      //                                 domain: "2000",
      //                                 measure: 100,
      //                               ),
      //                               OrdinalData(
      //                                 domain: "5000",
      //                                 measure: 8000,
      //                               ),
      //                               OrdinalData(
      //                                 domain: "3000",
      //                                 measure: 1600,
      //                               ),
      //                             ]
      //                         )
      //                       ],
      //                     ),
      //                   );
      //                 },
      //               );
      //             }else{
      //               return Center(child: CircularProgressIndicator());
      //             }
      //           },
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
