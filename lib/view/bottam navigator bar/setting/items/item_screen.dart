import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/app_api/app_api_service.dart';
import 'package:flutter_invoice_app/res/component/app_button.dart';
import 'package:flutter_invoice_app/res/component/invoice_text_field.dart';
import 'package:flutter_invoice_app/res/routes/routes.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../res/assets/assets_url.dart';
import '../../../../res/colors/app_colors.dart';

class ItemScreen extends StatefulWidget {
  const ItemScreen({Key? key}) : super(key: key);

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  TextEditingController category = TextEditingController();
  final _key = GlobalKey<FormState>();
  bool search = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
      return Scaffold(
        appBar: AppBar(
          title: search ?
          TextField(
            cursorHeight: 18,
            cursorColor: AppColor.whiteColor,
            style: GoogleFonts.lato(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColor.whiteColor,
            ),
            decoration: InputDecoration(
                hintText: "Items Name",
                hintStyle: GoogleFonts.lato(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColor.whiteColor,
                ),
                border: InputBorder.none
            ),
          ) :
          Text("Items"),
          actions: [
            IconButton(
              onPressed: (){
                if(search == false){
                  search = true;
                  setState(() {

                  });
                }else{
                  search = false;
                  setState(() {

                  });
                }
              },
              icon: Icon(CupertinoIcons.search),
            )
          ],
        ),
        body: StreamBuilder(
          stream: AppApiService.item.snapshots(),
          builder: (context,snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                itemCount: 2,
                itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    child: Container(
                      height: 160,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: AppColor.whiteColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 0.8,
                            color: Colors.grey,
                            offset: Offset(0.3, 0.2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Item Details",style: GoogleFonts.lato(fontWeight: FontWeight.w600,fontSize: 16),),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: (){},
                                      icon: AssetsUrl.categoryEditSvgIcon,
                                    ),
                                    IconButton(
                                      onPressed: (){},
                                      icon: Icon(CupertinoIcons.delete,size: 22,color: AppColor.errorColor,),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Product Name",style: GoogleFonts.lato(color: Colors.grey),),
                                Text("Pepsi",style: GoogleFonts.lato(color: AppColor.primaryColor,fontWeight: FontWeight.w600),),
                              ],
                            ),
                          ),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Price",style: GoogleFonts.lato(color: Colors.grey),),
                                Text("Rs. 350",style: GoogleFonts.lato(color: AppColor.primaryColor,fontWeight: FontWeight.w600),),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }else{
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Get.toNamed(AppRoutes.addItems);
          },
          child: Icon(Icons.add),
        ),
      );
  }
}
