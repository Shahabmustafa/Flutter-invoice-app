import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_chart/commons/config_render.dart';
import 'package:d_chart/commons/data_model.dart';
import 'package:d_chart/commons/enums.dart';
import 'package:d_chart/ordinal/combo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/app_api/app_api_service.dart';
import 'package:flutter_invoice_app/res/calculation/calculation.dart';
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
            cashSaleAmount() {
              List<dynamic> supplierPayment = data["cashSaleAmount"];
              int sum = 0;
              for (String amount in supplierPayment) {
                sum += int.tryParse(amount) ?? 0; // Parse string to int, default to 0 if parsing fails
              }
              return sum;
            }
            creditSale() {
              List<dynamic> supplierPayment = data["creditSale"];
              int sum = 0;
              for (String amount in supplierPayment) {
                sum += int.tryParse(amount) ?? 0; // Parse string to int, default to 0 if parsing fails
              }
              return sum;
            }
            var totalSaleAmount = Calculation().addTwoValue(cashSaleAmount().toString(), creditSale().toString());
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              child: Column(
                children: [
                  Container(
                    height: size.height * 0.3,
                    width: size.width * 1,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
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
                              "${cashSaleAmount()}",
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
                              "${creditSale()}",
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
                              "${totalSaleAmount}",
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
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  SizedBox(
                    height: 340,
                    child: AspectRatio(
                      aspectRatio: 16/9,
                      child: DChartComboO(
                        configRenderBar: ConfigRenderBar(maxBarWidthPx: 30),
                        groupList: [
                          OrdinalGroup(
                            id: "1",
                            chartType: ChartType.bar,
                            data: [
                              OrdinalData(
                                domain: "Cash Sale Amount",
                                measure: cashSaleAmount(),
                              ),
                              OrdinalData(
                                domain: "Credit Sale",
                                measure: creditSale(),
                              ),
                              OrdinalData(
                                domain: "Supplier Payment",
                                measure: supplierPayment(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                      ),
                ],
              ),
            );
          }else{
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
