import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/model/product_model.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';

class SaleInvoicePDFPrint {
  static Future<void> generateSimpleInvoice({
    required String invoiceId,
    required String customerName,
    required String subtotal,
    required String totalAmount,
    required String recievedAmount,
    required String discount,
    required String tax,
    required String date,
    required List<Product> product,
  }) async {
    final pdf = pw.Document();

    // // Load fonts
    // final regularFont = await PdfGoogleFonts.openSansRegular();
    // final boldFont = await PdfGoogleFonts.openSansBold();

    // Create invoice content
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Padding(
            padding: const pw.EdgeInsets.all(20),
            child: pw.Column(
              children: [
                // Invoice Header
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Invoice # $invoiceId', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Text('Date: $date', style: pw.TextStyle(fontSize: 12)),
                        pw.Text('Customer: $customerName', style: pw.TextStyle(fontSize: 12)),
                      ],
                    ),
                  ],
                ),
                pw.SizedBox(height: 20),
                // Product List Header
                pw.Table.fromTextArray(
                  context: context,
                  data: <List<String>>[
                    <String>['Product', 'Price', 'Stock', 'Discount', 'Tax'],
                    ...product.map((product) => [
                      product.product.toString(),
                      product.price.toString(),
                      product.stock.toString(),
                      product.discount.toString(),
                      product.tax.toString(),
                    ]),
                  ],
                  cellStyle: pw.TextStyle(fontSize: 10),
                  headerStyle: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
                  headerDecoration: pw.BoxDecoration(
                    color: PdfColors.grey300,
                  ),
                  border: pw.TableBorder.all(color: PdfColors.grey200),
                  cellAlignment: pw.Alignment.center,
                ),

                pw.SizedBox(height: 20),

                // Summary Section

                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('Subtotal:', style: pw.TextStyle(fontSize: 12)),
                        pw.Text('Discount:', style: pw.TextStyle(fontSize: 12)),
                        pw.Text('Tax:', style: pw.TextStyle(fontSize: 12)),
                        pw.Text('Total Amount:', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
                        pw.Text('Received Amount:', style: pw.TextStyle(fontSize: 12)),
                      ]
                    ),
                    pw.SizedBox(width: 20),
                    pw.Column(
                      children: [
                        pw.Text(subtotal, style: pw.TextStyle(fontSize: 12)),
                        pw.Text(discount, style: pw.TextStyle(fontSize: 12)),
                        pw.Text(tax, style: pw.TextStyle(fontSize: 12)),
                        pw.Text(totalAmount, style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
                        pw.Text(recievedAmount, style: pw.TextStyle(fontSize: 12)),
                      ],
                    ),
                  ],
                ),
                pw.SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );

    try {
      final output = await getTemporaryDirectory();
      final file = File("${output.path}/invoice_$invoiceId.pdf");
      await file.writeAsBytes(await pdf.save());

      // Print or Share the PDF
      await Printing.sharePdf(bytes: await pdf.save(), filename: 'invoice_$invoiceId.pdf');
    } catch (e) {
      debugPrint("Error generating PDF: $e");
    }
  }
}
