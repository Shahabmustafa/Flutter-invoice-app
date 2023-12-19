import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/app_api/app_api_service.dart';
import 'package:flutter_invoice_app/res/assets/assets_url.dart';
import 'package:flutter_invoice_app/res/colors/app_colors.dart';
import 'package:flutter_invoice_app/res/component/app_button.dart';
import 'package:flutter_invoice_app/res/routes/routes.dart';
import 'package:get/get.dart';
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
      body: StreamBuilder(
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
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    height: size.height * 0.6,
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
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppButton(
                              title: "Print",
                              height: 40,
                              width: 100,
                              onTap: ()async{
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
                                );
                                final pdfFile = await PdfInvoiceService.generate(itemModel);
                                PdfApi.openFile(pdfFile);
                              },
                            ),
                            AppButton(
                              title: "Delete",
                              height: 40,
                              width: 100,
                              onTap: ()async {
                                AppApiService.firestore
                                    .collection("users")
                                    .doc(AppApiService.userId)
                                    .collection("items")
                                    .doc(snapshot.data!.docs[index].id)
                                    .delete();
                              },
                            ),
                            AppButton(
                                title: "Update",
                                height: 40,
                                width: 100,
                                onTap: ()async {}
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }else{
            return CircularProgressIndicator();
          }
        },
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
