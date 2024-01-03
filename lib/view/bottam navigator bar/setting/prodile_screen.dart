import 'package:avatar_glow/avatar_glow.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../res/app_api/app_api_service.dart';
import '../../../res/colors/app_colors.dart';
import '../../../view model/image_picker/image_picker_service.dart';
import '../../../view model/user_service/user_image_service.dart';

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
    return Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
        ),
        body: StreamBuilder(
          stream: AppApiService.firestore.collection("users").doc(AppApiService.userId).snapshots(),
          builder: (context,snapshot){
            if(snapshot.hasData){
              Map<String,dynamic> data = snapshot.data!.data() as Map<String,dynamic>;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                    child: Center(
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color: AppColor.primaryColor,
                            width: 2.5,
                          ),
                        ),
                        child: AvatarGlow(
                          startDelay: const Duration(milliseconds: 1000),
                          glowColor: Colors.grey.shade300,
                          glowShape: BoxShape.circle,
                          animate: _animate,
                          curve: Curves.fastOutSlowIn,
                          child: Material(
                            elevation: 8.0,
                            shape: CircleBorder(),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: CachedNetworkImage(
                                imageUrl: data["profileImage"],
                                progressIndicatorBuilder: (context, url, downloadProgress) =>
                                    CircularProgressIndicator(value: downloadProgress.progress),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.person),
                      title: Text(data["userName"]),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.alternate_email),
                      title: Text(data["email"]),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.phone),
                      title: data["phoneNumber"].toString().isEmpty ? Text("03***********") : Text(data["phoneNumber"]),
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