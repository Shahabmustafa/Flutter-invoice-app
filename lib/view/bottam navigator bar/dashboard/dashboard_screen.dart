import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/assets/assets_url.dart';
import 'package:flutter_invoice_app/res/calculation/calculation.dart';
import 'package:flutter_invoice_app/utils/utils.dart';
import 'package:flutter_invoice_app/view/bottam%20navigator%20bar/dashboard/with_draw_screen.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../res/component/dashboard_summary.dart';

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
      body: Column(
        children: [
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("dashboard").doc(Calculation().date()).snapshots(),
            builder: (context,snapshot){
              if(snapshot.hasData){
                Map<dynamic,dynamic> data = snapshot.data!.data() as Map<dynamic,dynamic>;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: DashboardSummary(
                              imageAssets: AssetsUrl.cashSaleSvgIcon,
                              title: "Cash Sale",
                              subtitle: data["cashSale"].toString(),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            child: DashboardSummary(
                              imageAssets: AssetsUrl.creditCardSvgIcon,
                              title: "Expense",
                              subtitle: data["expense"].toString(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: DashboardSummary(
                              imageAssets: AssetsUrl.creditSaleSvgIcon,
                              title: "Credit Sale",
                              subtitle: (data["creditSale"] - data["totalInstallment"]).toString(),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            child: DashboardSummary(
                              imageAssets: AssetsUrl.supplierSaleSvgIcon,
                              title: "Supp Payment",
                              subtitle: data["supplierPayment"].toString(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: DashboardSummary(
                              imageAssets: AssetsUrl.totalInstallmentSvgIcon,
                              title: "Total Installment",
                              subtitle: data["totalInstallment"].toString(),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            child: DashboardSummary(
                              imageAssets: AssetsUrl.totalSaleSvgIcon,
                              title: "Total Sale",
                              subtitle: (data["cashSale"] + data["creditSale"]).toString(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Card(
                        child: ListTile(
                          leading: Icon(CupertinoIcons.arrow_right_circle_fill),
                          title: Text("With Draw"),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => WithDrawScreen()));
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }else if(snapshot.connectionState == ConnectionState.waiting){
                return Center(child: SizedBox());
              }else if (!snapshot.hasData || snapshot.data!.data() == null) {
                return Center(child: Text("No data available"));
              }else{
                return Center(child: SizedBox());
              }
            },
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("dashboard").orderBy("date", descending: false).limit(8).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final docs = snapshot.data!.docs;

                  /// Prepare data for the chart
                  List<ChartData> chartData = [];
                  /// Current date range
                  final today = DateTime.now();
                  final startDate = today.subtract(Duration(days: 7));

                  /// Track maximum sales and corresponding day
                  int maxSales = 0;
                  String? maxSalesDate;

                  /// Process Firestore data
                  for (var doc in docs) {
                    DateTime? date;

                    /// Parse the date field
                    if (doc["date"] is Timestamp) {
                      date = (doc["date"] as Timestamp).toDate();
                    } else if (doc["date"] is String) {
                      date = DateFormat("MMMM d, yyyy").parse(doc["date"]);
                    }

                    /// Skip invalid dates
                    if (date == null) continue;

                    /// Ensure the date is within the last 7 days
                    if (date.isBefore(startDate) || date.isAfter(today)) continue;

                    final sales = (doc["cashSale"] ?? 0).toInt();

                    /// Update max sales and corresponding date
                    if (sales > maxSales) {
                      maxSales = sales;
                      maxSalesDate = DateFormat("MMM d").format(date);
                    }

                    /// Add data to chart
                    chartData.add(ChartData(
                      DateFormat("MMM d").format(date), /// Format for X-axis
                      sales,
                    ));
                  }

                  /// Highlight the day with maximum sales
                  List<ColumnSeries<ChartData, String>> series = [
                    ColumnSeries<ChartData, String>(
                      dataSource: chartData,
                      xValueMapper: (ChartData data, _) => data.category,
                      yValueMapper: (ChartData data, _) => data.value,
                      name: 'Sales',
                      color: Colors.blue,
                    ),
                  ];

                  if (maxSalesDate != null) {
                    series.add(ColumnSeries<ChartData, String>(
                      dataSource: chartData.where((data) => data.category == maxSalesDate).toList(),
                      xValueMapper: (ChartData data, _) => data.category,
                      yValueMapper: (ChartData data, _) => data.value,
                      name: 'Highest Sales',
                      color: Colors.red, // Highlight with a different color
                    ));
                  }

                  return Column(
                    children: [
                      // Display bar chart
                      Expanded(
                        child: SfCartesianChart(
                          primaryXAxis: CategoryAxis(),
                          primaryYAxis: NumericAxis(),
                          legend: Legend(isVisible: true),
                          series: series,
                        ),
                      ),
                    ],
                  );
                } else {
                  return Center(child: Utils.circular);
                }
              },
            ),
          ),
        ],
      )
    );
  }
}

class ChartData {
  final String category;
  final int value;

  ChartData(this.category, this.value);
}
