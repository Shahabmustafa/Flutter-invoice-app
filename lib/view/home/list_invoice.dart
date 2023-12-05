

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/assets/assets_url.dart';
import 'package:flutter_invoice_app/res/fonts/app_fonts.dart';
import 'package:flutter_invoice_app/res/routes/routes.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../res/component/image_convert_to_icons.dart';

class ListInvoice extends StatefulWidget {
  const ListInvoice({Key? key}) : super(key: key);

  @override
  State<ListInvoice> createState() => _ListInvoiceState();
}

class _ListInvoiceState extends State<ListInvoice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Invoice"),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconWidget(
              imageUrl: AssetsUrl.addFile,
              onTap: (){
                Get.toNamed(AppRoutes.listofInvoice);
              },
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: null,
        builder: (context,snapshot){
          if(snapshot.hasData){
            return Text("Data He");
          }else{
            return Center(
              child: Text(
                "You Dont have any invoice!",
                style: GoogleFonts.aldrich(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )
              ),
            );
          }
        },
      ),
    );
  }
}
