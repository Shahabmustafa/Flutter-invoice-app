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
     AppApiService.auth.currentUser!
         .updateEmail(emailController.text)
         .then((value){
       reLoad.setLoading(false);
       FirebaseFirestore.instance
           .collection("users")
           .doc(AppApiService.userId)
           .update({
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
      ),
      body: Column(
        children: [
          Card(
            child: ListTile(
              leading: Icon(Icons.person),
              title: Text("Change Profile Detail"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: (){
                Get.toNamed(AppRoutes.changeProfileDetail);
              },
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.alternate_email),
              trailing: Icon(Icons.arrow_forward_ios),
              title: Text("Change Email"),
              onTap: (){
                showModalBottomSheet(
                  context: context,
                  builder: (context){
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Change Email",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Form(
                          key: _key,
                          child: Column(
                            children: [
                              InvoiceTextField(
                                title: "Current Email",
                                controller: emailController,
                              ),
                            ],
                          ),
                        ),
                        AppButton(
                          title: "Change Email",
                          height: size.height * 0.06,
                          width: size.width * 0.95,
                          loading: reLoad.loading.value,
                          onTap: (){
                            if(_key.currentState!.validate()){
                              emailChange();
                            }
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.key),
              title: Text("Change Password"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: (){
                showModalBottomSheet(
                  context: context,
                  builder: (context){
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Change Password",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Form(
                          key: _key,
                          child: Column(
                            children: [
                              InvoiceTextField(
                                title: "New Password",
                                controller: passwordController,
                                obscureText: visibility.value,
                                suffixIcon: Obx(() => GestureDetector(
                                  onTap: (){
                                    visibility.value =! visibility.value;
                                  },
                                  child: Icon(visibility.value ? Icons.visibility : Icons.visibility_off_outlined),
                                ),),
                                validator: (value){
                                  return passwordController.text.isEmpty ?
                                  "Please Enter New Password" :
                                  passwordController.text.length < 8 ?
                                  "Please Enter Eight Digits Password" :
                                      null;
                                },
                              ),
                            ],
                          ),
                        ),
                        AppButton(
                          title: "Change Password",
                          height: size.height * 0.06,
                          width: size.width * 0.95,
                          loading: reLoad.loading.value,
                          onTap: (){
                            if(_key.currentState!.validate()){
                              reLoad.setLoading(true);
                              try{
                                AppApiService.auth.currentUser!.updatePassword(
                                  passwordController.text,
                                ).then((value){
                                  reLoad.setLoading(false);
                                  Get.back();
                                }).onError((error, stackTrace){
                                  reLoad.setLoading(false);
                                });
                              }catch(e){
                                reLoad.setLoading(false);
                              }
                            }
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.language),
              title: Text("Change Language"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: (){
                Get.toNamed("/change_languages_routes");
              },
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.dark_mode),
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
          SizedBox(
            height: size.height * 0.01,
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.exit_to_app_rounded),
              title: Text("Logout"),
              onTap: (){
                AppApiService.auth.signOut().then((value){
                  Get.toNamed("/login_routes");
                  Utils.flutterToast("Log Out");
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
