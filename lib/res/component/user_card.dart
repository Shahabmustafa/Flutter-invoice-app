import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/app_api/app_api_service.dart';
import 'package:flutter_invoice_app/res/routes/routes.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade400,
                  highlightColor: Colors.grey.shade200,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                        ),
                        Container(
                          height: 100,
                          width: 170,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: 170,
                                height: 15.0,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade400,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                width: 150,
                                height: 12.0,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade400,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
        }
        },
    );
  }
}
