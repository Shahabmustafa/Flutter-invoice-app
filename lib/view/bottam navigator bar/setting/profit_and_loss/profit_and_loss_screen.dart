import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/component/app_button.dart';
import 'package:flutter_invoice_app/res/component/dashboard_summary.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../res/colors/app_colors.dart';
import '../../../../utils/utils.dart';

class ProfitAndLossScreen extends StatefulWidget {
  const ProfitAndLossScreen({super.key});

  @override
  State<ProfitAndLossScreen> createState() => _ProfitAndLossScreenState();
}

class _ProfitAndLossScreenState extends State<ProfitAndLossScreen> {

  List<int> days = [1,7,14,30,60];
  int selectValue = 1;
  int profitAndLoss = 0;
  DateTime get startDate {
    return DateTime.now().subtract(Duration(days: selectValue));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profit And Loss"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: DashboardSummary(
                    imageAssets: Icon(CupertinoIcons.up_arrow),
                    title: "Profit",
                    subtitle: profitAndLoss.toString(),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: days.length,
              itemBuilder: (context, index) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectValue == days[index] ? Colors.blue : Colors.grey[300],
                        foregroundColor: selectValue == days[index] ? Colors.white : Colors.black,
                        minimumSize: Size(80, 40),
                      ),
                      onPressed: () {
                        setState(() {
                          selectValue = days[index];
                        });
                      },
                      child: Text("${days[index]} Days"),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection("saleInvoice")
                  .where("date", isGreaterThanOrEqualTo: Timestamp.fromDate(startDate))
                  .orderBy("date", descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.docs.isEmpty) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(CupertinoIcons.doc_text, color: AppColor.primaryColor, size: 100),
                        SizedBox(height: 20),
                        Center(
                          child: Text(
                            "Sale Invoice is Empty",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    // Reset profit and loss before calculating
                    profitAndLoss = 0;

                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var invoice = snapshot.data!.docs[index];
                        var productList = invoice["productList"];

                        for (var product in productList) {
                          var totalSalePrice = product["stock"] * product["salePrice"];
                          var totalPurchasePrice = product["stock"] * product["purchasePrice"];
                          profitAndLoss += (totalSalePrice - totalPurchasePrice as int); // Accumulate profit
                        }

                        Timestamp timestamp = invoice['date'];
                        DateTime dateTime = timestamp.toDate();
                        String formattedDate = DateFormat('dd-MM-yyyy hh:mm a').format(dateTime);

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Card(
                            child: ExpansionTile(
                              title: Text(
                                "Invoice No " + invoice["invoiceId"].toString(),
                                style: GoogleFonts.lato(fontWeight: FontWeight.w600, fontSize: 16, color: AppColor.primaryColor),
                              ),
                              subtitle: Text(
                                "Total Amount " + invoice["totalAmount"].toString(),
                                style: GoogleFonts.lato(color: Colors.black),
                              ),
                              trailing: Text(
                                formattedDate,
                                style: GoogleFonts.lato(color: AppColor.blackColor, fontSize: 14),
                              ),
                              children: [
                                SizedBox(
                                  height: 200,
                                  child: ListView.builder(
                                    itemCount: productList.length,
                                    itemBuilder: (context, i) {
                                      var product = productList[i];
                                      var totalSalePrice = product["stock"] * product["salePrice"];
                                      var totalPurchasePrice = product["stock"] * product["purchasePrice"];
                                      var productProfit = totalSalePrice - totalPurchasePrice;

                                      return ListTile(
                                        leading: Text("${i + 1}"),
                                        title: Text(
                                          product["product"],
                                          style: GoogleFonts.lato(fontWeight: FontWeight.w600, fontSize: 16, color: AppColor.primaryColor),
                                        ),
                                        subtitle: Text(
                                          "Purchase Price: ${product["purchasePrice"]}\nSale Price: ${product["salePrice"]}\nStock: ${product["stock"]}",
                                        ),
                                        trailing: Text(
                                          "Profit " + productProfit.toString(),
                                          style: GoogleFonts.lato(fontWeight: FontWeight.w600, fontSize: 16, color: AppColor.primaryColor),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                } else {
                  return Center(child: Utils.circular);
                }
              },
            ),

          ),
        ],
      ),
    );
  }
}
