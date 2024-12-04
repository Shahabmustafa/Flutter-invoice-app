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
       "withDrawAmount" : recievedAmount.text,
       "date" : DateTime.now(),
     });
     setLoading(false);
     Get.back();
     recievedAmount.clear();
   }catch(e){
     setLoading(false);
   }
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
                          }
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
                        AppButton(
                          title: "Cancel",
                          height: 40,
                          width: 100,
                          color: AppColor.whiteColor,
                          textColor: AppColor.primaryColor,
                          onTap: (){
                            Get.back();
                          },
                        ),
                        Obx((){
                          return AppButton(
                            title: "WithDraw",
                            height: 40,
                            width: 100,
                            loading: loading.value,
                            onTap: () => withDraw(),
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
        label: Text("With Draw"),
      )
    );
  }
}
