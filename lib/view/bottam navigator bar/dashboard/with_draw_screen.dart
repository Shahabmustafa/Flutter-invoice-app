import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/app_api/app_api_service.dart';
import 'package:flutter_invoice_app/res/component/invoice_text_field.dart';
import 'package:flutter_invoice_app/view/bottam%20navigator%20bar/dashboard/dashboard_screen.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../res/assets/assets_url.dart';
import '../../../res/colors/app_colors.dart';

class WithDrawScreen extends StatefulWidget {
  const WithDrawScreen({super.key});

  @override
  State<WithDrawScreen> createState() => _WithDrawScreenState();
}

class _WithDrawScreenState extends State<WithDrawScreen> {

  TextEditingController recievedAmount = TextEditingController();

  withDraw()async{
    var draw = await AppApiService.firestore.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();
    await AppApiService.firestore.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update({
      "cashInHand" : draw.data()?['cashInHand'] - int.parse(recievedAmount.text) ?? 0,
    });
    AppApiService.firestore.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).
    collection("withdrawHistory").add({
      "withDrawAmount" : recievedAmount.text,
      "date" : DateTime.now(),
    });
    Get.back();
    recievedAmount.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("With Draw"),
      ),
      body: StreamBuilder(
        stream: AppApiService.firestore.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            Map<dynamic,dynamic> data = snapshot.data!.data() as Map<dynamic,dynamic>;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  DashboardSummary(
                    imageAssets: AssetsUrl.creditSaleSvgIcon,
                    title: "Cash in Hand",
                    subtitle: data["cashInHand"].toString(),
                    width: double.infinity,
                  ),
                  SizedBox(height: 20,),
                  Expanded(
                    child: StreamBuilder(
                      stream: AppApiService.firestore.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("withdrawHistory").orderBy("date",descending: true).snapshots(),
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
                                  title: Text(formattedDate.toString(),style: GoogleFonts.lato(fontSize: 14,fontWeight: FontWeight.normal,color: AppColor.grayColor)),
                                  subtitle: Text("Rs. " + snapshot.data!.docs[index]["withDrawAmount"].toString(),style: GoogleFonts.lato(fontSize: 16,fontWeight: FontWeight.bold,color: AppColor.blackColor),),
                                ),
                              );
                            }
                          );
                        }else{
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                  )
                ],
              ),
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
                title: Text("With Draw"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InvoiceTextField(
                      title: "With Draw Payment",
                      hintText: "Enter Amount",
                      controller: recievedAmount,
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
                          onPressed: () => withDraw(),
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
        label: Text("With Draw"),
      )
    );
  }
}
