import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_chart/commons/data_model/data_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/app_api/app_api_service.dart';
import 'package:flutter_invoice_app/res/assets/assets_url.dart';
import 'package:flutter_invoice_app/res/colors/app_colors.dart';
import 'package:flutter_invoice_app/view/bottam%20navigator%20bar/dashboard/with_draw_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
            stream: AppApiService.dashboard.snapshots(),
            builder: (context,snapshot){
              if(snapshot.hasData){
                Map<dynamic,dynamic> data = snapshot.data!.data() as Map<dynamic,dynamic>;
                return Column(
                  children: [
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        DashboardSummary(
                          imageAssets: AssetsUrl.cashSaleSvgIcon,
                          title: "Cash Sale",
                          subtitle: data["cashSale"].toString(),
                        ),
                        DashboardSummary(
                          imageAssets: AssetsUrl.creditCardSvgIcon,
                          title: "Credit Card",
                          subtitle: data["creditCard"].toString(),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        DashboardSummary(
                          imageAssets: AssetsUrl.creditSaleSvgIcon,
                          title: "Credit Sale",
                          subtitle: data["creditSale"].toString(),
                        ),
                        DashboardSummary(
                          imageAssets: AssetsUrl.supplierSaleSvgIcon,
                          title: "Supplier Payment",
                          subtitle: data["supplierPayment"].toString(),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        DashboardSummary(
                          imageAssets: AssetsUrl.totalInstallmentSvgIcon,
                          title: "Total Installment",
                          subtitle: data["totalInstallment"].toString(),
                        ),
                        DashboardSummary(
                          imageAssets: AssetsUrl.totalSaleSvgIcon,
                          title: "Total Sale",
                          subtitle: (data["cashSale"] + data["creditSale"]).toString(),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                      child: Card(
                        child: ListTile(
                          title: Text("With Draw"),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => WithDrawScreen()));
                          },
                        ),
                      ),
                    ),
                  ],
                );
              }else{
                return Center(child: CircularProgressIndicator());
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
                  return Center(child: CircularProgressIndicator());
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

class DashboardSummary extends StatelessWidget {
  DashboardSummary({
    required this.imageAssets,
    required this.title,
    required this.subtitle,
    this.width = 190,
    super.key,
  });
  String title;
  String subtitle;
  Widget imageAssets;
  double? width;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 90,
      width: width,
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        boxShadow: [
          BoxShadow(
            color: AppColor.grayColor.withOpacity(0.2),
            blurRadius: 10,
            offset: Offset(0.2, 0.1),
          ),
        ],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          imageAssets,
          // AssetsUrl.cashSaleSvgIcon,
          SizedBox(width: 10,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,style: GoogleFonts.lora(fontSize: 12,fontWeight: FontWeight.bold),),
              Text(subtitle,style: GoogleFonts.lora(fontSize: 12,fontWeight: FontWeight.w400),),
            ],
          ),
        ],
      ),
    );
  }
}
