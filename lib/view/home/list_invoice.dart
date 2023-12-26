import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/controllers/flip_card_controllers.dart';
import 'package:flutter_flip_card/flipcard/flip_card.dart';
import 'package:flutter_flip_card/modal/flip_side.dart';
import 'package:flutter_invoice_app/res/app_api/app_api_service.dart';
import 'package:flutter_invoice_app/res/assets/assets_url.dart';
import 'package:flutter_invoice_app/res/colors/app_colors.dart';
import 'package:flutter_invoice_app/res/routes/routes.dart';
import 'package:flutter_invoice_app/view%20model/notification_service/notification_service.dart';
import 'package:flutter_invoice_app/view/home/invoice/item/update_item.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../model/item_model.dart';
import '../../res/component/image_convert_to_icons.dart';
import '../../res/component/text_widget.dart';
import '../../view model/pdf_service/pdf_invice_service.dart';

class ListInvoice extends StatefulWidget {
  const ListInvoice({Key? key}) : super(key: key);

  @override
  State<ListInvoice> createState() => _ListInvoiceState();
}

class _ListInvoiceState extends State<ListInvoice> {

  final con = FlipCardController();

  void launchWhatsApp({required String phone,required String message,}) async  {
      String url = "https://wa.me/$phone?text=$message";
      await canLaunch(url) ? await launch(url) : print("can't open whatsapp");
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildProfile(),
            Text("Invoice"),
            IconWidget(
              imageUrl: AssetsUrl.addFile,
              onTap: (){
                Get.toNamed(AppRoutes.addItem);
              },
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
                stream: AppApiService.firestore
                    .collection("users")
                    .doc(AppApiService.userId)
                    .collection("items")
                    .snapshots(),
                builder: (context,snapshot){
                  if(snapshot.hasData){
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context,index){
                        return FlipCard(
                          backWidget: Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            height: size.height * 0.3,
                            width: size.width * 1,
                            decoration: BoxDecoration(
                              color: AppColor.whiteColor,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 0.3,
                                    spreadRadius: 0.1,
                                    offset: Offset(0.1,1)
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextWidgets(
                                  title: "Item Name",
                                  subtitle: snapshot.data!.docs[index]["itemName"],
                                ),
                                TextWidgets(
                                  title: "Item Price",
                                  subtitle: snapshot.data!.docs[index]["itemCost"],
                                ),
                                TextWidgets(
                                  title: "Discount",
                                  subtitle: "${snapshot.data!.docs[index]["discount"]}%",
                                ),
                                TextWidgets(
                                  title: "Tax",
                                  subtitle: "${snapshot.data!.docs[index]["tax"]}%",
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Divider(
                                    color: AppColor.primaryColor,
                                  ),
                                ),
                                TextWidgets(
                                  title: "Total",
                                  subtitle: snapshot.data!.docs[index]["total"],
                                ),
                                TextWidgets(
                                  title: "Paid",
                                  subtitle: snapshot.data!.docs[index]["paid"],
                                ),
                                TextWidgets(
                                  title: "Total Debt",
                                  subtitle: snapshot.data!.docs[index]["totalDept"],
                                ),
                              ],
                            ),
                          ),
                          controller: con,
                          axis:  FlipAxis.horizontal,
                          onTapFlipping: true,
                          rotateSide: RotateSide.left,
                          frontWidget: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              height: size.height * 0.3,
                              width: size.width * 1,
                              decoration: BoxDecoration(
                                color: AppColor.whiteColor,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 0.3,
                                      spreadRadius: 0.1,
                                      offset: Offset(0.1,1)
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextWidgets(
                                    title: "Start Date",
                                    subtitle: snapshot.data!.docs[index]["dateNow"],
                                  ),
                                  TextWidgets(
                                    title: "Due Date",
                                    subtitle: snapshot.data!.docs[index]["duaDate"],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextWidgets(
                                    title: "Customer Name",
                                    subtitle: snapshot.data!.docs[index]["customerName"],
                                  ),
                                  TextWidgets(
                                    title: "C-Email",
                                    subtitle: snapshot.data!.docs[index]["customerEmail"],
                                  ),
                                  TextWidgets(
                                    title: "Phone Number",
                                    subtitle: snapshot.data!.docs[index]["customerPhone"],
                                  ),
                                  TextWidgets(
                                    title: "Address",
                                    subtitle: snapshot.data!.docs[index]["customerAddress"],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        onPressed: ()async{
                                          ItemModel itemModel = ItemModel(
                                            customerName: snapshot.data!.docs[index]["customerName"],
                                            customerEmail: snapshot.data!.docs[index]["customerEmail"],
                                            customerPhone: snapshot.data!.docs[index]["customerPhone"],
                                            customerAddress: snapshot.data!.docs[index]["customerAddress"],
                                            itemName: snapshot.data!.docs[index]["itemName"],
                                            itemCost: snapshot.data!.docs[index]["itemCost"],
                                            discount: snapshot.data!.docs[index]["discount"],
                                            tax: snapshot.data!.docs[index]["tax"],
                                            total: snapshot.data!.docs[index]["total"],
                                            paid: snapshot.data!.docs[index]["paid"],
                                            totalDept: snapshot.data!.docs[index]["totalDept"],
                                            duaDate: snapshot.data!.docs[index]["duaDate"],
                                            dateNow: snapshot.data!.docs[index]["dateNow"],
                                          );
                                          final pdfFile = await PdfInvoiceService.generate(itemModel);
                                          PdfApi.openFile(pdfFile);
                                        },
                                        icon: Icon(Icons.print),
                                      ),
                                      IconButton(
                                        onPressed: (){
                                          AppApiService.firestore
                                              .collection("users")
                                              .doc(AppApiService.userId)
                                              .collection("items")
                                              .doc(snapshot.data!.docs[index].id)
                                              .delete().then((value) => NotificationService().simpleNotificationShow("Your Invoice is Delete"));
                                        },
                                        icon: Icon(Icons.delete,color: AppColor.errorColor,),
                                      ),
                                      IconButton(
                                        onPressed: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateItem(updateId: snapshot.data!.docs[index].id)));
                                        },
                                        icon: Icon(Icons.update,color: Colors.green,),
                                      ),
                                      IconButton(
                                        onPressed: (){
                                          print("sdsdd");
                                          launchWhatsApp(phone: "+923112445554", message: "Please Pay Payment Last Date ${snapshot.data!.docs[index]["duaDate"]}");
                                        },
                                        icon: Icon(Icons.near_me,color: Colors.blue,),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }else{
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
          ),
        ],
      ),
    );
  }
  static Widget buildProfile(){
    return StreamBuilder(
        stream: AppApiService.firestore.collection("users").doc(AppApiService.userId).snapshots(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            Map<String,dynamic> data = snapshot.data!.data() as Map<String,dynamic>;
            return  GestureDetector(
              onTap: (){
                Get.toNamed(AppRoutes.userProfile);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CachedNetworkImage(
                  width: 40,
                  height: 40,
                  imageUrl: data["profileImage"],
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(value: downloadProgress.progress),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            );
          }else{
            return SizedBox();
          }
        },
    );
  }
}
