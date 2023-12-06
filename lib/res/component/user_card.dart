import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/app_api/app_api_service.dart';
import 'package:flutter_invoice_app/res/routes/routes.dart';
import 'package:get/get.dart';
import '../colors/app_colors.dart';
import '../fonts/app_fonts.dart';

class UserCard extends StatelessWidget {
  const UserCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var date = DateTime.now();
    var formattedDate = "${date.day}-${date.month}-${date.year}";
    final size = MediaQuery.sizeOf(context);
    return StreamBuilder(
        stream: AppApiService.firestore.collection("users").doc(AppApiService.userId).snapshots(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            Map<String,dynamic> data = snapshot.data!.data() as Map<String,dynamic>;
            return Container(
              height: size.height * 0.1,
              width:  size.width * 1,
              decoration: BoxDecoration(
                  color: AppColor.whiteColor,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                        color: AppColor.grayColor,
                        spreadRadius: 0.1,
                        blurRadius: 1,
                        offset: Offset(2,2)
                    ),
                  ]
              ),
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedNetworkImage(
                    width: 50,
                    height: 50,
                    imageUrl: data["profileImage"],
                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                        CircularProgressIndicator(value: downloadProgress.progress),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                title: Text(
                  data['userName'],
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
                subtitle: Text(
                  "Create on $formattedDate",
                  style: TextStyle(
                    color: AppColor.grayColor,
                  ),
                ),
                onTap: (){
                  Get.toNamed(AppRoutes.userProfile);
                },
              ),
            );
          }else{
            return CircularProgressIndicator();
          }
        },
    );
  }
}
