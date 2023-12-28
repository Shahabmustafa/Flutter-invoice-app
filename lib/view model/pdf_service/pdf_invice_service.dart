// import 'dart:io';
//
// import 'package:flutter_invoice_app/res/colors/app_colors.dart';
// import 'package:flutter_invoice_app/res/component/text_widget.dart';
// import 'package:open_file/open_file.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:pdf/widgets.dart';
//
// import '../../model/item_model.dart';
//
// class PdfInvoiceService{
//
//   static Future<File> generate(ItemModel itemModel)async{
//     final pdf = Document();
//     pdf.addPage(
//       MultiPage(
//           build: (context) => [
//             SizedBox(
//               height: 3 * PdfPageFormat.cm,
//             ),
//             buildTitle(itemModel),
//             SizedBox(
//               height: 3 * PdfPageFormat.cm,
//             ),
//             Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                         "Item Name",
//                         style: TextStyle(
//                           fontWeight: FontWeight.normal,
//                           fontSize: 15,
//                         )
//                     ),
//                     Text(
//                         itemModel.itemName.toString(),
//                         style: TextStyle(
//                             fontWeight: FontWeight.normal,
//                             fontSize: 15
//                         )
//                     ),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                         "Item Price",
//                         style: TextStyle(
//                             fontWeight: FontWeight.normal,
//                             fontSize: 15
//                         )
//                     ),
//                     Text(
//                         itemModel.itemCost.toString(),
//                         style: TextStyle(
//                             fontWeight: FontWeight.normal,
//                             fontSize: 15
//                         )
//                     ),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                         "Discount",
//                         style: TextStyle(
//                             fontWeight: FontWeight.normal,
//                             fontSize: 15
//                         )
//                     ),
//                     Text(
//                         "${itemModel.discount.toString()}%",
//                         style: TextStyle(
//                             fontWeight: FontWeight.normal,
//                             fontSize: 15
//                         )
//                     ),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                         "Tax",
//                         style: TextStyle(
//                             fontWeight: FontWeight.normal,
//                             fontSize: 15
//                         )
//                     ),
//                     Text(
//                         "${itemModel.tax.toString()}%",
//                         style: TextStyle(
//                             fontWeight: FontWeight.normal,
//                             fontSize: 15
//                         )
//                     ),
//                   ],
//                 ),
//                 Divider(),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Text(
//                         "Total",
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 15
//                         )
//                     ),
//                     SizedBox(
//                       width: 40
//                     ),
//                     Text(
//                         "${itemModel.total.toString()}",
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 15
//                         )
//                     ),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Text(
//                         "Paid",
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 15
//                         )
//                     ),
//                     SizedBox(
//                       width: 50,
//                     ),
//                     Text(
//                         "${itemModel.paid.toString()}",
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 15
//                         )
//                     ),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Text(
//                         "Total Dept",
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 15
//                         )
//                     ),
//                     SizedBox(
//                       width: 40,
//                     ),
//                     Text(
//                         "${itemModel.totalDept.toString()}",
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 15
//                         )
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//       ),
//     );
//     return PdfApi.saveDocument(name: "Invoice.pdf", pdf: pdf);
//   }
//
//
//   static Widget buildTitle(ItemModel itemModel){
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//             itemModel.customerName.toString(),
//             style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold
//             )
//         ),
//         SizedBox(
//           height: 0.1 * PdfPageFormat.cm,
//         ),
//         Text(
//           itemModel.customerEmail.toString(),
//         ),
//         SizedBox(
//           height: 0.1 * PdfPageFormat.cm,
//         ),
//         Text(
//           itemModel.customerPhone.toString(),
//         ),
//         SizedBox(
//           height: 0.1 * PdfPageFormat.cm,
//         ),
//         Text(
//           itemModel.customerAddress.toString(),
//         ),
//         SizedBox(
//           height: 0.1 * PdfPageFormat.cm,
//         ),
//         Text(
//           "${itemModel.dateNow.toString()} to ${itemModel.duaDate.toString()}",
//         ),
//
//       ],
//     );
//   }
//
//
// }
//
//
//
// class PdfApi{
//
//   static Future<File> saveDocument({required String name,required Document pdf})async{
//     final bytes = await pdf.save();
//     final dir = await getApplicationCacheDirectory();
//     final file = File("${dir.path}/$name");
//
//     await file.writeAsBytes(bytes);
//     return file;
//   }
//
//   static Future openFile(File file)async{
//     final url = file.path;
//     await OpenFile.open(url);
//   }
// }