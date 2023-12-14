


import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../res/colors/app_colors.dart';
import '../../../../res/component/app_button.dart';
import '../../../../res/component/invoice_text_field.dart';
import '../../../../view model/invoice service/Item_service.dart';
import '../../../../view model/invoice service/inoice_service.dart';

class AddItem extends StatefulWidget {
  const AddItem({Key? key}) : super(key: key);

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final _key = GlobalKey<FormState>();
  final itemService = Get.put(ItemService());


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Item"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.1,
              ),
              InvoiceTextField(
                title: "Item Name",
                controller: itemService.itemName.value,
                validator: (value){
                  return value!.isEmpty ? "Enter Your Item Name" : null;
                },
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              InvoiceTextField(
                title: "Quantity",
                keyboardType: TextInputType.number,
                controller: itemService.itemQuantity.value,
                validator: (value){
                  return value!.isEmpty ? "Enter Your Item Quantity" : null;
                },
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              InvoiceTextField(
                title: "Item Whole Price",
                controller: itemService.WholePrice.value,
                validator: (value){
                  return value!.isEmpty ? "Enter Your Item Whole Price" : null;
                },
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              InvoiceTextField(
                title: "Item Price",
                keyboardType: TextInputType.number,
                controller: itemService.itemCost.value,
                validator: (value){
                  return value!.isEmpty ? "Enter Your Item Price" : null;
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
                    loading: itemService.loading.value,
                    onTap: (){
                      if(_key.currentState!.validate()){
                        itemService.addItem(context);
                      }
                    },
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
