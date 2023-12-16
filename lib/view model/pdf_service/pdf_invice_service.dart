import 'dart:io';
import 'package:flutter_invoice_app/model/invoice_model.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../model/item_model.dart';

class PdfInvoiceService{

  static Future<File> generate(ItemModel itemModel)async{
    final pdf = Document();
    pdf.addPage(
      MultiPage(
          build: (context) => [
            SizedBox(
              height: 3 * PdfPageFormat.cm,
            ),
            buildTitle(itemModel),
            SizedBox(
              height: 3 * PdfPageFormat.cm,
            ),
            buildInvoice(itemModel),
            Divider(),
            buildTotal(itemModel),
            ],
        footer: (context) => buildFooter(itemModel),
      ),
    );
    return PdfApi.saveDocument(name: "Invoice.pdf", pdf: pdf);
  }


  static Widget buildTitle(ItemModel itemModel){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            itemModel.customerName.toString(),
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
            )
        ),
        SizedBox(
          height: 0.1 * PdfPageFormat.cm,
        ),
        Text(
          itemModel.customerEmail.toString(),
        ),
        SizedBox(
          height: 0.1 * PdfPageFormat.cm,
        ),
        Text(
          itemModel.customerPhone.toString(),
        ),
      ],
    );
  }

  static Widget buildInvoice(ItemModel itemModel){
    final header = [
      "Item Name",
      "Item Cost",
      "Tax",
      "Discount",
    ];

    List Data = [
      itemModel.itemName,
      itemModel.itemCost.toString(),
      "${itemModel.tax.toString()}%",
      "${itemModel.discount.toString()}%",
    ];


    return Table.fromTextArray(
      headers: header,
      data: [
        Data,
      ],
      border: null,
      headerStyle: TextStyle(fontWeight: FontWeight.bold,color: PdfColor.fromInt(0xFFFFFF)),
      headerDecoration: BoxDecoration(color: PdfColor.fromInt(0xFF59e1d6)),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerLeft,
        2: Alignment.centerLeft,
        3: Alignment.centerLeft,
      },
    );
  }

  static Widget buildTotal(ItemModel itemModel){
    return Container(
      alignment: Alignment.centerRight,
      child: Row(
        children: [
          Spacer(flex: 10),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildText(
                  title: "Total",
                  value: itemModel.total.toString(),
                  unite: true
                ),
                buildText(
                    title: "Paid",
                    value: itemModel.paid.toString(),
                    unite: true
                ),
                buildText(
                    title: "Total dept",
                    value: itemModel.totalDept.toString(),
                    unite: true
                ),
              ],
            ),
          ),
        ],
      )
    );
  }

  static Widget buildFooter(ItemModel itemModel) => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Divider(),
      SizedBox(height: 2 * PdfPageFormat.mm),
      buildSimpleText(title: "Address", value: itemModel.customerAddress.toString()),
    ]
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