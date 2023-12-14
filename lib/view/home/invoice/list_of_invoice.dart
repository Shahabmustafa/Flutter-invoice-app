import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/assets/assets_url.dart';
import 'package:flutter_invoice_app/res/component/app_button.dart';
import 'package:flutter_invoice_app/res/component/image_convert_to_icons.dart';
import 'package:flutter_invoice_app/res/component/invoice_box.dart';
import 'package:flutter_invoice_app/res/routes/routes.dart';
import 'package:get/get.dart';


class ListOfInvoice extends StatefulWidget {
  const ListOfInvoice({Key? key}) : super(key: key);

  @override
  State<ListOfInvoice> createState() => _ListOfInvoiceState();
}

class _ListOfInvoiceState extends State<ListOfInvoice> {

  @override
  Widget build(BuildContext context) {
    final _key = GlobalKey<FormState>();
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("New Invoice"),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconWidget(
              imageUrl: AssetsUrl.closeIcon,
              onTap: (){
                Get.back();
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.02,
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            InvoiceBox(
              title: "Customer",
              subtitle: "add your Customer details",
              icon: Icons.home_work_outlined,
              onTap: (){
                Get.toNamed(AppRoutes.listCustomer);
              },
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            InvoiceBox(
              title: "Items",
              subtitle: "add Items to your Invoice",
              icon: CupertinoIcons.shopping_cart,
              onTap: (){
                Get.toNamed(AppRoutes.itemList);
              },
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            AppButton(
              height: size.height * 0.06,
              width: size.width * 0.94,
              title: "Save",
              // loading: invoiceService.loading.value,
              onTap: (){
                Get.back();
              },
            )
          ],
        ),
      ),
    );
  }
}


