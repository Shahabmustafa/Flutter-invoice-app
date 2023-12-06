import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/colors/app_colors.dart';
import 'package:flutter_invoice_app/view%20model/invoice%20service/add_item_service.dart';
import 'package:get/get.dart';

import '../../../res/component/app_button.dart';
import '../../../res/component/invoice_text_field.dart';

class ItemList extends StatefulWidget {
  const ItemList({Key? key}) : super(key: key);

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  final _key = GlobalKey<FormState>();
  final invoiceItem = Get.put(AddItemService());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("List of Item"),
      ),
      body: Column(
        children: [

        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showModalBottomSheet(
            context: context,
            builder: (context){
              return Form(
                key: _key,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Text(
                      "Add new Item",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppColor.primaryColor,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    InvoiceTextField(
                      title: "Item Name",
                      controller: invoiceItem.itemName.value,
                      validator: (value){
                        return value!.isEmpty ? "Enter Your Item Name" : null;
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    InvoiceTextField(
                      title: "Item Cost",
                      keyboardType: TextInputType.number,
                      controller: invoiceItem.itemCost.value,
                      validator: (value){
                        return value!.isEmpty ? "Enter Your Item Cost" : null;
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    InvoiceTextField(
                      title: "Quantity",
                      keyboardType: TextInputType.number,
                      controller: invoiceItem.quantity.value,
                      validator: (value){
                        return value!.isEmpty ? "Enter Your Item Quantity" : null;
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Obx(() =>
                        AppButton(
                          title: "Add Item",
                          height: size.height * 0.05,
                          width: size.width * 0.94,
                          loading: invoiceItem.loading.value,
                          onTap: (){
                            if(_key.currentState!.validate()){
                              invoiceItem.addItem(context);
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
        child: Icon(Icons.add),
      ),
    );
  }
}
