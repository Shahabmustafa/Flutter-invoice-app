import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/calculation/calculation.dart';
import 'package:flutter_invoice_app/res/component/app_button.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../res/app_api/app_api_service.dart';
import '../../../../res/colors/app_colors.dart';
import '../../../../res/component/dashboard_summary.dart';
import '../../../../res/component/invoice_text_field.dart';
import '../../../../utils/utils.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {

  TextEditingController recievedAmount = TextEditingController();
  TextEditingController description = TextEditingController();
  RxBool loading = false.obs;
  setLoading(bool value){
    loading.value = value;
  }

  expense()async{
    try{
      setLoading(true);
      var draw = await AppApiService.firestore.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();
      var expense = await AppApiService.firestore.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("dashboard").doc(Calculation().date()).get();
      await AppApiService.firestore.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update({
        "cashInHand" : draw.data()?['cashInHand'] - int.parse(recievedAmount.text) ?? 0,
      });
      setLoading(false);
      AppApiService.firestore.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("dashboard").doc(Calculation().date()).update({
        "expense" : expense.data()?["expense"] + int.parse(recievedAmount.text),
      });
      setLoading(false);
      AppApiService.firestore.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("expense").add({
        "expense" : recievedAmount.text,
        "date" : DateTime.now(),
        "description" : description.text,
      });
      setLoading(false);
      Get.back();
      recievedAmount.clear();
      description.clear();
    }catch(e){
      setLoading(false);
    }
  }

  List<int> days = [1,7,14,30,60];
  int selectValue = 1;


  DateTime get startDate {
    return DateTime.now().subtract(Duration(days: selectValue));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("expense").where("date", isGreaterThanOrEqualTo: Timestamp.fromDate(startDate)).orderBy("date", descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            double expense = 0.0;
            for (var doc in snapshot.data!.docs) {
              expense += double.parse(doc["expense"].toString());
            }
            if (snapshot.data!.docs.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.arrow_down_circle, color: AppColor.primaryColor, size: 100),
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      "Expense is Empty",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              );
            }
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: DashboardSummary(
                          imageAssets: Icon(CupertinoIcons.arrow_down_circle),
                          title: "Expense",
                          subtitle: expense.toStringAsFixed(0),
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
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      Timestamp timestamp = snapshot.data!.docs[index]['date'];
                      DateTime dateTime = timestamp.toDate();
                      String formattedDate =
                      DateFormat('dd-MM-yyyy hh:mm a').format(dateTime);

                      return Card(
                        child: ListTile(
                          leading: Text("${index + 1}"),
                          trailing: Text(formattedDate.toString(),
                              style: GoogleFonts.lato(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: AppColor.grayColor)),
                          title: Text(
                            "Rs. " + snapshot.data!.docs[index]["expense"].toString(),
                            style: GoogleFonts.lato(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColor.blackColor),
                          ),
                          subtitle: Text(
                            snapshot.data!.docs[index]["description"].toString(),
                            style: GoogleFonts.lato(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: AppColor.grayColor),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return Center(child: Utils.circular);
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            showDialog(
              context: context,
              builder: (context){
                return StatefulBuilder(
                  builder: (context,setState){
                    return AlertDialog(
                      title: Text("Add Expense"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InvoiceTextField(
                            title: "Expense Payment",
                            hintText: "Enter Amount",
                            controller: recievedAmount,
                            onlyNumber: true,
                          ),
                          SizedBox(height: 10,),
                          InvoiceTextField(
                            title: "Description",
                            hintText: "Enter Description",
                            controller: description,
                          ),
                          SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppButton(
                                title: "Cancel",
                                height: 40,
                                width: 100,
                                onTap: (){
                                  Get.back();
                                },
                              ),
                              Obx((){
                                return AppButton(
                                  title: "Pay",
                                  height: 40,
                                  width: 100,
                                  loading: loading.value,
                                  onTap: () => expense(),
                                );
                              }),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          },
          label: Text("Add Expense"),
        ),
    );
  }
}
