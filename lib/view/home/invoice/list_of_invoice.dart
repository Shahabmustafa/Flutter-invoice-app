import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/assets/assets_url.dart';
import 'package:flutter_invoice_app/res/colors/app_colors.dart';
import 'package:flutter_invoice_app/res/component/app_button.dart';
import 'package:flutter_invoice_app/res/component/image_convert_to_icons.dart';
import 'package:flutter_invoice_app/res/component/invoice_box.dart';
import 'package:flutter_invoice_app/res/component/invoice_text_field.dart';
import 'package:flutter_invoice_app/res/routes/routes.dart';
import 'package:get/get.dart';

import '../../../res/component/user_card.dart';
import '../../../view model/invoice service/inoice_service.dart';

class ListOfInvoice extends StatefulWidget {
  const ListOfInvoice({Key? key}) : super(key: key);

  @override
  State<ListOfInvoice> createState() => _ListOfInvoiceState();
}

class _ListOfInvoiceState extends State<ListOfInvoice> {
  final invoiceService = Get.put(InvoiceService());

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
            UserCard(),
            SizedBox(
              height: size.height * 0.02,
            ),
            InvoiceBox(
              title: "Your Details",
              subtitle: "aadd your business details",
              icon: Icons.home_work_outlined,
              onTap: (){
                Get.toNamed(AppRoutes.yourDetails);
              },
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            InvoiceBox(
              title: "Invoice to",
              subtitle: "add payer",
              icon: Icons.person_add_alt_outlined,
              onTap: (){
                Get.toNamed(AppRoutes.addPayer);
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
            InvoiceBox(
              title: "Payment",
              subtitle: "add payment instruction",
              icon: Icons.payment,
              onTap: (){
                showModalBottomSheet(
                  context: context,
                  builder: (context){
                    return Form(
                      key: _key,
                      child: Column(
                        children: [
                          SizedBox(
                            height: size.height * 0.04,
                          ),
                          Text(
                            "Payment Instructions",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColor.primaryColor,
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.04,
                          ),
                          InvoiceTextField(
                            title: "Note",
                            controller: invoiceService.note.value,
                            maxLines: 6,
                            validator: (value){
                              return value!.isEmpty ? "Enter Your Payment Instructions" : null;
                            },
                          ),
                          SizedBox(
                            height: size.height * 0.04,
                          ),
                          Obx(() =>
                              AppButton(
                                height: size.height * 0.05,
                                width: size.width * 0.94,
                                title: "Save",
                                loading: invoiceService.loading.value,
                                onTap: (){
                                  if(_key.currentState!.validate()){
                                    // paymentService.Payment(context);
                                  }
                                },
                              ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            InvoiceBox(
              title: "Signature",
              subtitle: "Sign your invoice",
              icon: Icons.edit,
              onTap: (){
                Get.toNamed(AppRoutes.signature);
              },
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            AppButton(
              height: size.height * 0.06,
              width: size.width * 0.94,
              title: "Save",
              loading: invoiceService.loading.value,
              onTap: (){
                invoiceService.Invoice(context);
              },
            )
          ],
        ),
      ),
    );
  }
}


