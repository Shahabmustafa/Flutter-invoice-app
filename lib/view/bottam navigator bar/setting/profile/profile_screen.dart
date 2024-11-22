import 'package:avatar_glow/avatar_glow.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/assets/assets_url.dart';
import 'package:flutter_invoice_app/res/routes/routes.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../res/app_api/app_api_service.dart';
import '../../../../res/colors/app_colors.dart';
import '../../../../view model/image_picker/image_picker_service.dart';
import '../../../../view model/user_service/user_image_service.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final profileUpdate = Get.put(UserProfileService());
  final pickImage = Get.put(ImagePickerService());
  bool _animate = true;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
        appBar: AppBar(
          title: Text("Profile"),
        ),
        body: StreamBuilder(
          stream: AppApiService.firestore.collection("users").doc(AppApiService.userId).snapshots(),
          builder: (context,snapshot){
            if(snapshot.hasData){
              Map<String,dynamic> data = snapshot.data!.data() as Map<String,dynamic>;
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SizedBox(height: 10,),
                      GestureDetector(
                        onTap: (){
                          showModalBottomSheet(
                            context: context,
                            builder: (context){
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    leading: Icon(Icons.camera_alt),
                                    title: Text("Camera"),
                                    trailing: Icon(Icons.arrow_forward_ios),
                                    onTap: (){
                                      pickImage.getImage(context, ImageSource.camera).then((value){
                                        profileUpdate.storeImage();
                                      });
                                    },
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.photo),
                                    title: Text("Gallery"),
                                    trailing: Icon(Icons.arrow_forward_ios),
                                    onTap: (){
                                      pickImage.getImage(context, ImageSource.gallery).then((value){
                                        profileUpdate.storeImage();
                                      });
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: CachedNetworkImage(
                            imageUrl: data["profileImage"],
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                            progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text(data["userName"],style: GoogleFonts.lato(fontSize: 16,fontWeight: FontWeight.w700,color: AppColor.whiteColor),),
                      SizedBox(height: 5,),
                      Text(data["phoneNumber"],style: GoogleFonts.lato(fontSize: 16,fontWeight: FontWeight.normal,color: AppColor.whiteColor.withOpacity(0.7)),),
                    ],
                  ),
                  Container(
                    height: size.height * 0.7,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColor.whiteColor,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: kToolbarHeight,
                        ),
                        Container(
                          height: size.height * 0.22,
                          width: size.width * 0.85,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColor.whiteColor,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 6,
                                blurStyle: BlurStyle.outer,
                                spreadRadius: 4.1,
                                offset: Offset(2.1, 2.1),
                                color: Colors.grey.shade300,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Email",style: GoogleFonts.lato(fontSize: 16,color: AppColor.primaryColor,),),
                                  Text(data["email"])
                                ],
                              ),
                              SizedBox(height: 10,),
                              Divider(color: AppColor.grayColor,thickness: 0.5,),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Cash in Hand",style: GoogleFonts.lato(fontSize: 16,color: AppColor.primaryColor,),),
                                  Text(data["cashInHand"].toString())
                                ],
                              ),
                              SizedBox(height: 10,),
                              Divider(color: AppColor.grayColor,thickness: 0.5,),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Phone",style: GoogleFonts.lato(fontSize: 16,color: AppColor.primaryColor,),),
                                  Text(data["phoneNumber"])
                                ],
                              ),
                              SizedBox(height: 10,),
                              Divider(color: AppColor.grayColor,thickness: 0.5,),
                            ],
                          ),
                        ),
                        SizedBox(height: 40,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Card(
                            child: ListTile(
                              leading: AssetsUrl.changePasswordSvgIcon,
                              title: Text("Change Password"),
                              onTap: (){
                                Get.toNamed(AppRoutes.changePasswordScreen);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }else{
              return Center(child: CircularProgressIndicator());
            }
          },
        )
    );
  }
}