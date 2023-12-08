import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/app_api/app_api_service.dart';
import 'package:flutter_invoice_app/res/colors/app_colors.dart';
import 'package:flutter_invoice_app/res/routes/routes.dart';
import 'package:get/get.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: (){
                Get.toNamed(AppRoutes.setting);
              },
              child: Icon(
                Icons.settings,
              ),
            ),
          )
        ],
      ),
      body: StreamBuilder(
        stream: AppApiService.userdb.snapshots(),
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

                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.photo),
                              title: Text("Gallery"),
                              trailing: Icon(Icons.arrow_forward_ios),
                              onTap: (){

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
                SizedBox(
                  height: 20,
                ),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.numbers),
                    title: Text(data["specificId"]),
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
