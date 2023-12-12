import 'dart:io';
import 'package:flutter_invoice_app/model/invoice_model.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../model/item_model.dart';

class PdfInvoiceService{

  static Future<File> generate(InvoiceModel invoiceModel,ItemModel itemModel)async{
    final pdf = Document();
    pdf.addPage(
      MultiPage(
          build: (context) => [
            buildHeader(),
            SizedBox(
              height: 3 * PdfPageFormat.cm,
            ),
            buildTitle(invoiceModel),
            SizedBox(
              height: 3 * PdfPageFormat.cm,
            ),
            buildInvoice(itemModel),
            Divider(),
            buildTotal(),
            ],
        footer: (context) => buildFooter(),
      ),
    );
    return PdfApi.saveDocument(name: "Invoice.pdf", pdf: pdf);
  }


  static Widget buildTitle(InvoiceModel invoiceModel){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            invoiceModel.businessName.toString(),
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
            )
        ),
        SizedBox(
          height: 0.1 * PdfPageFormat.cm,
        ),
        Text(
          invoiceModel.businessEmail.toString(),
        ),
        SizedBox(
          height: 0.1 * PdfPageFormat.cm,
        ),
        Text(
          invoiceModel.businessAddress.toString(),
        ),
      ],
    );
  }

  static Widget buildInvoice(ItemModel itemModel){
    final header = [
      "Item Name",
      "Item Cost",
      "Item Quantity",
      "Total",
    ];


    return Table.fromTextArray(
      headers: header,
      data: [],
      border: null,
      headerStyle: TextStyle(fontWeight: FontWeight.bold,color: PdfColor.fromInt(0xFFFFFF)),
      headerDecoration: BoxDecoration(color: PdfColor.fromInt(0xFF59e1d6)),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerLeft,
        2: Alignment.centerLeft,
        3: Alignment.centerLeft,
        4: Alignment.centerRight,
        5: Alignment.centerRight,
      },
    );
  }

  static Widget buildTotal(){
    return Container(
      alignment: Alignment.centerRight,
      child: Row(
        children: [
          Spacer(flex: 6),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildText(
                  title: "total",
                  value: "3300",
                  unite: true
                ),
              ],
            ),
          ),
        ],
      )
    );
  }

  static Widget buildFooter() => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Divider(),
      SizedBox(height: 2 * PdfPageFormat.mm),
      buildSimpleText(title: "Address", value: "Hussain Town Street no 4"),
      SizedBox(height: 2 * PdfPageFormat.mm),
      buildSimpleText(title: "Paypal", value: "Hussain Town Street no 4"),
    ],
  );

  static Widget buildHeader() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 1 * PdfPageFormat.cm,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildSupplierddress(),
          Container(
            height: 50,
            width: 50,
            child: BarcodeWidget(
              data: "03112445554",
              barcode: Barcode.aztec(),
            ),
          ),
        ],
      ),
    ],
  );

  static Widget buildSupplierddress() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("INVOICE ID 16343434454",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
    ],
  );

  static buildSimpleText({
    required String title,
    required String value,
}){
    final style = TextStyle(fontWeight: FontWeight.bold,);
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        Text(title,style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value),
      ],
    );
  }

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }){
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);
    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title,style: style)),
          Text(value,style: unite ? style : null),
        ],
      ),
    );
  }
}



class PdfApi{

  static Future<File> saveDocument({required String name,required Document pdf})async{
    final bytes = await pdf.save();
    final dir = await getApplicationCacheDirectory();
    final file = File("${dir.path}/$name");

    await file.writeAsBytes(bytes);
    return file;
  }

  static Future openFile(File file)async{
    final url = file.path;
    await OpenFile.open(url);
  }
}