import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/model/invoice_model.dart';
import 'package:flutter_invoice_app/model/item_model.dart';
import 'package:flutter_invoice_app/res/app_api/app_api_service.dart';
import 'package:flutter_invoice_app/res/colors/app_colors.dart';

import '../../view model/pdf_service/pdf_invice_service.dart';

class InvoiceDetail extends StatelessWidget {
  InvoiceDetail({Key? key,required this.invoiceModel}) : super(key: key);
  InvoiceModel invoiceModel;
  ItemModel? itemModel;
  final item = FirebaseFirestore.instance.collection("users").doc(AppApiService.userId).collection("items");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Invoice Detail"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: ()async{
                final pdfFile = await PdfInvoiceService.generate(invoiceModel,itemModel!);
                PdfApi.openFile(pdfFile);
              },
              child: Icon(
                Icons.print,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              child: Container(
                padding: EdgeInsets.only(left: 10),
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 0.1,
                      spreadRadius: 0.1,
                      blurStyle: BlurStyle.solid,
                      offset: Offset(0.004,0.5)
                    ),
                  ]
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: CachedNetworkImage(
                            width: 60,
                            height: 60,
                            fit: BoxFit.fill,
                            imageUrl: invoiceModel.businessLogo.toString(),
                            progressIndicatorBuilder: (context, url, downloadProgress) =>
                                CircularProgressIndicator(value: downloadProgress.progress),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(invoiceModel.businessName.toString(),style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),),
                                Text(invoiceModel.businessEmail.toString(),style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15),),
                              ],
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(invoiceModel.businessNumber.toString(),style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15),),
                                Text(invoiceModel.businessAddress.toString(),style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15),),                                  ],
                            ),

                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                height: 200,
                width: double.infinity,
                child: StreamBuilder(
                  stream: item.snapshots(),
                  builder: (context,snapshot){
                    if(snapshot.hasData){
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context,index){
                          itemModel = ItemModel(
                            itemName: snapshot.data!.docs[index]["itemName"],
                            itemCost: snapshot.data!.docs[index]["itemCost"],
                            itemQuantity: snapshot.data!.docs[index]["itemQuantity"],
                            total: snapshot.data!.docs[index]["total"],
                          );
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            child: Container(
                              height: 80,
                              width: 200,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColor.whiteColor,
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 0.1,
                                        spreadRadius: 0.1,
                                        blurStyle: BlurStyle.solid,
                                        offset: Offset(0.004,0.5)
                                    ),
                                  ]
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: AppColor.primaryColor,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 5),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          InkWell(
                                            onTap: (){
                                              item.doc(snapshot.data!.docs[index].id).delete();
                                            },
                                              child: Center(
                                                child: Icon(
                                                  Icons.close,
                                                  color: AppColor.whiteColor,
                                                  size: 20,
                                                ),
                                              ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        "Item Name",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500
                                        ),
                                      ),
                                      Text(
                                        snapshot.data!.docs[index]["itemName"],
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        "Item Cost",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500
                                        ),
                                      ),
                                      Text(
                                        snapshot.data!.docs[index]["itemCost"],
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        "Item Quantity",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500
                                        ),
                                      ),
                                      Text(
                                        snapshot.data!.docs[index]["itemQuantity"],
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Divider(color: AppColor.primaryColor,),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        "Total",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500
                                        ),
                                      ),
                                      Text(
                                        snapshot.data!.docs[index]["total"],
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                        ),
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
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                padding: EdgeInsets.only(left: 10,right: 10),
                height: 150,
                decoration: BoxDecoration(
                  color: AppColor.whiteColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 0.1,
                        spreadRadius: 0.1,
                        blurStyle: BlurStyle.solid,
                        offset: Offset(0.004,0.5)
                      ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Payer Name",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17),),
                        Text(invoiceModel.payerName.toString(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17),),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Payer Email",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17),),
                        Text(invoiceModel.payerEmail.toString(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17),),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Payer Number",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17),),
                        Text(invoiceModel.payerNumber.toString(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17),),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Payer Address",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17),),
                        Text(invoiceModel.payerAddress.toString(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17),),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 0.1,
                          spreadRadius: 0.1,
                          blurStyle: BlurStyle.solid,
                          offset: Offset(0.004,0.5)
                      ),
                    ]
                ),
                child: Center(
                  child: CachedNetworkImage(
                    width: 200,
                    height: 100,
                    fit: BoxFit.fill,
                    imageUrl: invoiceModel.signature.toString(),
                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                        CircularProgressIndicator(value: downloadProgress.progress),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
