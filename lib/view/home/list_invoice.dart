import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/app_api/app_api_service.dart';
import 'package:flutter_invoice_app/res/assets/assets_url.dart';
import 'package:flutter_invoice_app/res/colors/app_colors.dart';
import 'package:flutter_invoice_app/res/routes/routes.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../res/component/image_convert_to_icons.dart';
import '../../view model/pdf_service/pdf_invice_service.dart';

class ListInvoice extends StatefulWidget {
  const ListInvoice({Key? key}) : super(key: key);

  @override
  State<ListInvoice> createState() => _ListInvoiceState();
}

class _ListInvoiceState extends State<ListInvoice> {
  static var date = DateTime.now();
  var formattedDate = "${date.day}-${date.month}-${date.year}";
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
        stream: AppApiService.invoice.snapshots(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context,index){
                return Card(
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CachedNetworkImage(
                        width: 50,
                        height: 50,
                        fit: BoxFit.fill,
                        imageUrl: snapshot.data!.docs[index]['businessLogo'],
                        progressIndicatorBuilder: (context, url, downloadProgress) =>
                            CircularProgressIndicator(value: downloadProgress.progress),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                    title: Text(snapshot.data!.docs[index]['businessName']),
                    subtitle: Text(snapshot.data!.docs[index]['businessEmail']),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: (){},
                          child: Icon(Icons.download),
                        ),
                        InkWell(
                          onTap: (){
                            AppApiService.invoice.doc(snapshot.data!.docs[index].id).delete();
                          },
                          child: Icon(
                            Icons.delete,
                            color: AppColor.errorColor,
                          ),
                        ),
                      ],
                    ),
                    onTap: ()async{
                      final pdfFile = await PdfInvoiceService.generate();
                      PdfApi.openFile(pdfFile);
                    },
                  ),
                );
              },
            );
          }else{
            return Center(
              child: Text(
                "You Dont have any invoice!",
                style: GoogleFonts.aldrich(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.displayLarge!.color,
                )
              ),
            );
          }
        },
      ),
    );
  }
}
