import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/app_api/app_api_service.dart';
import 'package:flutter_invoice_app/res/colors/app_colors.dart';
import 'package:flutter_invoice_app/res/component/app_button.dart';
import 'package:flutter_invoice_app/res/component/invoice_text_field.dart';
import 'package:flutter_invoice_app/res/routes/routes.dart';
import 'package:flutter_invoice_app/utils/utils.dart';
import 'package:flutter_invoice_app/view%20model/auth%20service/login_service.dart';
import 'package:get/get.dart';

import '../../../../../view model/swith_service/swith_service.dart';
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
     AppApiService.auth.currentUser!.updateEmail(emailController.text).then((value){
       reLoad.setLoading(false);
       FirebaseFirestore.instance.collection("users").doc(AppApiService.userId).update({
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
                    Get.toNamed(AppRoutes.Order);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              child: Card(
                child: ListTile(
                  leading: AssetsUrl.accountSvgIcon,
                  title: Text("Account"),
                  onTap: (){
                    // Get.toNamed(AppRoutes.changeProfileDetail);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              child: Card(
                child: ListTile(
                  leading:  AssetsUrl.changeLanguageSvgIcon,
                  title: Text("Change Language"),
                  onTap: (){
                    Get.toNamed("/change_languages_routes");
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              child: Card(
                child: ListTile(
                  leading: AssetsUrl.darkModeSvgIcon,
                  title: Text("Dark Mode"),
                  trailing: GetBuilder<ThemeController>(
                    builder: (controller) {
                      return Switch(
                        activeColor: AppColor.primaryColor,
                        value: controller.isDark,
                        onChanged: (value) {
                          controller.changeTheme(value);
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              child: Card(
                child: ListTile(
                  leading: AssetsUrl.logoutSvgIcon,
                  title: Text("Logout"),
                  onTap: (){
                    AppApiService.auth.signOut().then((value){
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
