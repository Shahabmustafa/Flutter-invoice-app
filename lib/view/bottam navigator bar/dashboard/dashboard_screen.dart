import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/app_api/app_api_service.dart';

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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: size.height * 0.5,
              width: size.width * 1,
              child: StreamBuilder(
                stream: AppApiService.order.snapshots(),
                builder: (context,snapshot){
                  if(snapshot.hasData){
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context,index){
                        return AspectRatio(
                          aspectRatio: 1,
                          child: DChartBarO(
                            animate: true,
                            configRenderBar: ConfigRenderBar(
                                maxBarWidthPx: 50,
                                minBarLengthPx: 100
                            ),
                            animationDuration: Duration(seconds: 3),
                            groupList: [
                              OrdinalGroup(
                                  id: "ssss",
                                  chartType: ChartType.line,
                                  data: [
                                    OrdinalData(
                                      domain: "2000",
                                      measure: 100,
                                    ),
                                    OrdinalData(
                                      domain: "5000",
                                      measure: 8000,
                                    ),
                                    OrdinalData(
                                      domain: "3000",
                                      measure: 1600,
                                    ),
                                  ]
                              )
                            ],
                          ),
                        );
                      },
                    );
                  }else{
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
