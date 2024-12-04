import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/colors/app_colors.dart';
import 'package:flutter_invoice_app/res/component/app_button.dart';
import 'package:flutter_invoice_app/res/routes/routes.dart';
import 'package:flutter_invoice_app/utils/utils.dart';
import 'package:flutter_invoice_app/view%20model/auth%20service/delete_account_controller.dart';
import 'package:flutter_invoice_app/view%20model/auth%20service/login_service.dart';
import 'package:get/get.dart';

import '../../../res/assets/assets_url.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final reLoad = Get.put(LoginService());
  final _key = GlobalKey<FormState>();

  Future<void> emailChange()async{
    reLoad.setLoading(true);
   try{
     FirebaseAuth.instance.currentUser!.updateEmail(emailController.text).then((value){
       reLoad.setLoading(false);
       FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update({
         "email" : emailController.text,
       },).then((value){
         reLoad.setLoading(false);
         Get.back();
         emailController.clear();
       }).onError((error, stackTrace){
         reLoad.setLoading(false);
       });
     }).onError((error, stackTrace){
       reLoad.setLoading(false);
     });
   }catch(e){
     reLoad.setLoading(false);
   }
  }

  RxBool visibility = true.obs;
  final deleteAccount = Get.put(DeleteAccountController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              child: Card(
                child: ListTile(
                  leading: AssetsUrl.profileSvgIcon,
                  title: Text("Profile"),
                  onTap: (){
                    Get.toNamed(AppRoutes.userProfile);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              child: Card(
                child: ListTile(
                  leading: AssetsUrl.categorySvgIcon,
                  title: Text("Add Category"),
                  onTap: (){
                    Get.toNamed(AppRoutes.categoryScreen);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              child: Card(
                child: ListTile(
                  leading: AssetsUrl.addItemSvgIcon,
                  title: Text("Add Items"),
                  onTap: (){
                    Get.toNamed(AppRoutes.Items);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              child: Card(
                child: ListTile(
                  leading: AssetsUrl.customerSvgIcon,
                  title: Text("Customer"),
                  onTap: (){
                    Get.toNamed(AppRoutes.Customer);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              child: Card(
                child: ListTile(
                  leading: AssetsUrl.customerInstallmentSvgIcon,
                  title: Text("Customer Installment"),
                  onTap: (){
                    Get.toNamed(AppRoutes.customerInstallmentScreen);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              child: Card(
                child: ListTile(
                  leading:  AssetsUrl.supplierSvgIcon,
                  title: Text("Supplier"),
                  onTap: (){
                    Get.toNamed(AppRoutes.Supplier);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              child: Card(
                child: ListTile(
                  leading:  AssetsUrl.supplierInstallmentSvgIcon,
                  title: Text("Supplier Installment"),
                  onTap: (){
                    Get.toNamed(AppRoutes.supplierInstallmentScreen);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              child: Card(
                child: ListTile(
                  leading: AssetsUrl.orderSvgIcon,
                  title: Text("Order"),
                  onTap: (){
                    Get.toNamed(AppRoutes.orderInvoiceScreen);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              child: Card(
                child: ListTile(
                  leading: Icon(CupertinoIcons.money_dollar_circle,size: 30,),
                  title: Text("Expense"),
                  onTap: (){
                    Get.toNamed(AppRoutes.expenseScreen);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              child: Card(
                child: ListTile(
                  leading: Icon(CupertinoIcons.time,size: 30,),
                  title: Text("Dashboard History"),
                  onTap: (){
                    Get.toNamed(AppRoutes.dashboardHistory);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              child: Card(
                child: ListTile(
                  leading: Icon(CupertinoIcons.person_badge_minus,size: 30,),
                  title: Text("Delete Account"),
                  onTap: (){
                    showDialog(
                      context: context,
                      builder: (context){
                        return AlertDialog(
                          title: Text("Do You Want to Delete Account?",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AppButton(
                                title: "No",
                                color: AppColor.whiteColor,
                                textColor: AppColor.primaryColor,
                                height: 40,
                                width: 100,
                                onTap: (){
                                  Get.back();
                                },
                              ),
                              Obx((){
                                return AppButton(
                                  title: "Yes",
                                  height: 40,
                                  width: 100,
                                  loading: deleteAccount.loading.value,
                                  onTap: (){
                                    deleteAccount.deleteAccount();
                                  },
                                );
                              }),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
            //   child: Card(
            //     child: ListTile(
            //       leading: AssetsUrl.darkModeSvgIcon,
            //       title: Text("Dark Mode"),
            //       trailing: GetBuilder<ThemeController>(
            //         builder: (controller) {
            //           return Switch(
            //             activeColor: AppColor.primaryColor,
            //             value: controller.isDark,
            //             onChanged: (value) {
            //               controller.changeTheme(value);
            //             },
            //           );
            //         },
            //       ),
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              child: Card(
                child: ListTile(
                  leading: AssetsUrl.logoutSvgIcon,
                  title: Text("Logout"),
                  onTap: (){
                    FirebaseAuth.instance.signOut().then((value){
                      Get.toNamed("/login_routes");
                      Utils.flutterToast("Log Out");
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
