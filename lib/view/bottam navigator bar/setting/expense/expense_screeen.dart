


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/calculation/calculation.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../res/app_api/app_api_service.dart';
import '../../../../res/colors/app_colors.dart';
import '../../../../res/component/invoice_text_field.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {

  TextEditingController recievedAmount = TextEditingController();
  TextEditingController description = TextEditingController();

  expense()async{
    var draw = await AppApiService.firestore.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();
    var expense = await AppApiService.firestore.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("dashboard").doc(Calculation().date()).get();
    await AppApiService.firestore.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update({
      "cashInHand" : draw.data()?['cashInHand'] - int.parse(recievedAmount.text) ?? 0,
    });
    AppApiService.firestore.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("dashboard").doc(Calculation().date()).update({
      "expense" : expense.data()?["expense"] + int.parse(recievedAmount.text),
    });
    AppApiService.firestore.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("expense").add({
      "expense" : recievedAmount.text,
      "date" : DateTime.now(),
      "description" : description.text,
    });
    Get.back();
    recievedAmount.clear();
    description.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("expense").snapshots(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context,index){
                  Timestamp timestamp = snapshot.data!.docs[index]['date'];
                  DateTime dateTime = timestamp.toDate();
                  String formattedDate = DateFormat('dd-MMMM-yyyy').format(dateTime);
                  return Card(
                    child: ListTile(
                      leading: Text("${index + 1}"),
                      trailing: Text(formattedDate.toString(),style: GoogleFonts.lato(fontSize: 14,fontWeight: FontWeight.normal,color: AppColor.grayColor)),
                      title: Text("Rs. " + snapshot.data!.docs[index]["expense"].toString(),style: GoogleFonts.lato(fontSize: 16,fontWeight: FontWeight.bold,color: AppColor.blackColor),),
                      subtitle: Text(snapshot.data!.docs[index]["description"].toString(),style: GoogleFonts.lato(fontSize: 12,fontWeight: FontWeight.normal,color: AppColor.grayColor),),
                    ),
                  );
                }
            );
          }else{
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            showDialog(
              context: context,
              builder: (context){
                return AlertDialog(
                  title: Text("Add Expense"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InvoiceTextField(
                        title: "Expense Payment",
                        hintText: "Enter Amount",
                        controller: recievedAmount,
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
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.whiteColor,
                              foregroundColor: AppColor.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                  color: AppColor.primaryColor,
                                ),
                              ),
                            ),
                            onPressed: (){
                              Get.back();
                            },
                            child: Text("Cancel"),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.primaryColor,
                              foregroundColor: AppColor.whiteColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                  color: AppColor.primaryColor,
                                ),
                              ),
                            ),
                            onPressed: () => expense(),
                            child: Text("Received"),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
          label: Text("Add Expense"),
        ),
    );
  }
}
