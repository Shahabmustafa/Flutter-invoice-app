import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/assets/assets_url.dart';
import 'package:flutter_invoice_app/res/colors/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

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
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DashboardSummary(
                imageAssets: AssetsUrl.cashSaleSvgIcon,
                title: "Cash Sale",
                subtitle: "1200",
              ),
              DashboardSummary(
                imageAssets: AssetsUrl.creditCardSvgIcon,
                title: "Credit Card",
                subtitle: "1200",
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
                subtitle: "1200",
              ),
              DashboardSummary(
                imageAssets: AssetsUrl.supplierSaleSvgIcon,
                title: "Supplier Payment",
                subtitle: "1200",
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
                subtitle: "1200",
              ),
              DashboardSummary(
                imageAssets: AssetsUrl.totalSaleSvgIcon,
                title: "Total Sale",
                subtitle: "1200",
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DashboardSummary extends StatelessWidget {
  DashboardSummary({
    required this.imageAssets,
    required this.title,
    required this.subtitle,
    super.key,
  });
  String title;
  String subtitle;
  Widget imageAssets;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 90,
      width: 190,
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
