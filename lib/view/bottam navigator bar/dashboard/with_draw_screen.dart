import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/app_api/app_api_service.dart';
import 'package:flutter_invoice_app/res/component/app_button.dart';
import 'package:flutter_invoice_app/res/component/invoice_text_field.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../res/assets/assets_url.dart';
import '../../../res/colors/app_colors.dart';
import '../../../res/component/dashboard_summary.dart';
import '../../../utils/utils.dart';

class WithDrawScreen extends StatefulWidget {
  const WithDrawScreen({super.key});

  @override
  State<WithDrawScreen> createState() => _WithDrawScreenState();
}

class _WithDrawScreenState extends State<WithDrawScreen> {

  TextEditingController recievedAmount = TextEditingController();
  RxBool loading = false.obs;

  setLoading(bool value){
    loading.value = value;
  }

  withDraw()async{
   try{
     setLoading(true);
     var draw = await AppApiService.firestore.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();
     await AppApiService.firestore.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update({
       "cashInHand" : draw.data()?['cashInHand'] - int.parse(recievedAmount.text) ?? 0,
     });
     AppApiService.firestore.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).
     collection("withdrawHistory").add({
       "withDrawAndAddAmount" : recievedAmount.text,
       "date" : DateTime.now(),
       "type" : "withDraw",
     });
     setLoading(false);
     Get.back();
     recievedAmount.clear();
   }catch(e){
     setLoading(false);
   }
  }

  addAmount()async{
   try{
     setLoading(true);
     var draw = await AppApiService.firestore.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();
     await AppApiService.firestore.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update({
       "cashInHand" : draw.data()?['cashInHand'] + int.parse(recievedAmount.text) ?? 0,
     });
     AppApiService.firestore.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).
     collection("withdrawHistory").add({
       "withDrawAndAddAmount" : recievedAmount.text,
       "date" : DateTime.now(),
       "type" : "addAmount",
     });
     setLoading(false);
     Get.back();
     recievedAmount.clear();
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
        title: Text("Add Amount & With Draw"),
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
                      stream: AppApiService.firestore.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).
                      collection("withdrawHistory").where("date", isGreaterThanOrEqualTo: Timestamp.fromDate(startDate)).
                      orderBy("date", descending: true).snapshots(),
                      builder: (context,snapshot){
                        if(snapshot.hasData){
                          // double cashInHand = 0.0;
                          // for (var doc in snapshot.data!.docs) {
                          //   cashInHand += double.parse(doc["withDrawAndAddAmount"].toString());
                          // }
                          if(snapshot.data!.docs.isEmpty){
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(CupertinoIcons.arrow_up_circle,color: AppColor.primaryColor,size: 100,),
                                SizedBox(
                                  height: 20,
                                ),
                                Center(
                                  child: Text(
                                    "WithDraw is Empty",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }else{
                            return Column(
                              children: [
                                // Padding(
                                //   padding: const EdgeInsets.all(10.0),
                                //   child: Row(
                                //     children: [
                                //       Expanded(
                                //         child: DashboardSummary(
                                //           imageAssets: Icon(CupertinoIcons.calendar),
                                //           title: "Total Cash In Hand",
                                //           subtitle: "${cashInHand.toStringAsFixed(0)}",
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                // SizedBox(
                                //   height: 60,
                                //   child: ListView.builder(
                                //     scrollDirection: Axis.horizontal,
                                //     itemCount: days.length,
                                //     itemBuilder: (context, index) {
                                //       return Center(
                                //         child: Padding(
                                //           padding: const EdgeInsets.all(10),
                                //           child: ElevatedButton(
                                //             style: ElevatedButton.styleFrom(
                                //               backgroundColor: selectValue == days[index]
                                //                   ? Colors.blue
                                //                   : Colors.grey[300],
                                //               foregroundColor: selectValue == days[index]
                                //                   ? Colors.white
                                //                   : Colors.black,
                                //               minimumSize: Size(80, 40),
                                //             ),
                                //             onPressed: () {
                                //               setState(() {
                                //                 selectValue = days[index];
                                //               });
                                //             },
                                //             child: Text("${days[index]} Days"),
                                //           ),
                                //         ),
                                //       );
                                //     },
                                //   ),
                                // ),
                                Expanded(
                                  child: ListView.builder(
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (context,index){
                                        Timestamp timestamp = snapshot.data!.docs[index]['date'];
                                        DateTime dateTime = timestamp.toDate();
                                        String formattedDate = DateFormat('dd-MM-yyyy hh:mm a').format(dateTime);
                                        return Card(
                                          child: ListTile(
                                            leading: Icon(snapshot.data!.docs[index]["type"] == "addAmount" ?
                                            CupertinoIcons.arrow_down_left :
                                            CupertinoIcons.arrow_up_right,
                                              color: snapshot.data!.docs[index]["type"] == "addAmount" ? Colors.green : Colors.redAccent,
                                            ),
                                            title: Text(formattedDate.toString(),style: GoogleFonts.lato(fontSize: 14,fontWeight: FontWeight.normal,color: AppColor.grayColor)),
                                            trailing: Text("Rs. " + snapshot.data!.docs[index]["withDrawAndAddAmount"].toString(),style: GoogleFonts.lato(fontSize: 16,fontWeight: FontWeight.bold,color: AppColor.blackColor),),
                                            subtitle: Text(snapshot.data!.docs[index]["type"] == "addAmount" ? "Add Amount" : "WithDraw Amount"),
                                          ),
                                        );
                                      }
                                  ),
                                ),
                              ],
                            );
                          }
                        }else{
                          return Center(child: Utils.circular);
                        }
                      },
                    ),
                  )
                ],
              ),
            );
          }else{
            return Center(child: Utils.circular);
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          showDialog(
            context: context,
            builder: (context){
              return AlertDialog(
                title: Text("Add Amount & With Draw"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InvoiceTextField(
                      title: "Add Payment",
                      hintText: "Enter Amount",
                      controller: recievedAmount,
                      onlyNumber: true,
                    ),
                    SizedBox(height: 20,),
                    Obx((){
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppButton(
                            title: "Add Amount",
                            height: 40,
                            width: 100,
                            color: AppColor.whiteColor,
                            textColor: AppColor.primaryColor,
                            loading: loading.value,
                            onTap: () => addAmount(),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          AppButton(
                            title: "WithDraw",
                            height: 40,
                            width: 100,
                            loading: loading.value,
                            onTap: () => withDraw(),
                          )
                        ],
                      );
                    }),
                  ],
                ),
              );
            },
          );
        },
        label: Text("With Draw"),
      ),
    );
  }
}
