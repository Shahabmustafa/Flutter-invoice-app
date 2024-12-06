import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/view%20model/firebase/item_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../../res/component/app_button.dart';
import '../../../../../../res/component/invoice_text_field.dart';

class AddItems extends StatefulWidget {
  const AddItems({Key? key}) : super(key: key);

  @override
  State<AddItems> createState() => _AddItemsState();
}

class _AddItemsState extends State<AddItems> {
  final _key = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  final item = Get.put(ItemController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Item"),
      ),
      body: SingleChildScrollView(
        child: Obx((){
          return Form(
            key: _key,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Obx((){
                    return InvoiceTextField(
                      title: "Barcode",
                      controller: item.barcode.value,
                    );
                  }),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  InvoiceTextField(
                    title: "Item Name",
                    controller: item.itemName.value,
                    validator: (value){
                      return value!.isEmpty ? "Enter Your Item Name" : null;
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: InvoiceTextField(
                          title: "Sale",
                          controller: item.sale.value,
                          keyboardType: TextInputType.number,
                          validator: (value){
                            return value!.isEmpty ? "Enter Your Item Price" : null;
                          },
                        ),
                      ),
                      SizedBox(width: size.width * 0.04,),
                      Flexible(
                        child: InvoiceTextField(
                          title: "Cost",
                          controller: item.cost.value,
                          keyboardType: TextInputType.number,
                          validator: (value){
                            return value!.isEmpty ? "Enter Your Item Whole Price" : null;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: InvoiceTextField(
                          title: "Discount",
                          controller: item.discount.value,
                          keyboardType: TextInputType.number,
                          validator: (value){
                            return value!.isEmpty ? "Enter Your Item discount" : null;
                          },
                        ),
                      ),
                      SizedBox(width: size.width * 0.04,),
                      Flexible(
                        child: InvoiceTextField(
                          title: "Tax",
                          controller: item.tax.value,
                          keyboardType: TextInputType.number,
                          suffix: Text("%"),
                          validator: (value){
                            return value!.isEmpty ? "Enter Your Item Whole Price" : null;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  InvoiceTextField(
                    title: "Stocks",
                    controller: TextEditingController(text: 0.toString()),
                    keyboardType: TextInputType.number,
                    enabled: false,
                    validator: (value){
                      return value!.isEmpty ? "Enter Your Item Name" : null;
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  DropdownSearch<String>(
                    items: (f, cs) => item.dropdownCategory,
                    dropdownBuilder: (context, selectedItem) {
                      if (selectedItem == null) {
                        return Text("Please Select Category");
                      }
                      return Text(selectedItem);
                    },
                    popupProps: PopupProps.menu(
                      showSearchBox: true,
                      showSelectedItems: true,
                      itemBuilder: (ctx, item, isDisabled, isSelected) {
                        return ListTile(
                          title: Text(item),
                        );
                      },
                      constraints: BoxConstraints(
                        maxHeight: (item.dropdownCategory.length > 5) ? 300.0 : 150.0,
                      ),
                    ),
                    onChanged: (value){
                      item.selectCategory.value = value!;
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  DropdownSearch<String>(
                    items: (es,i) => item.dropdownCompany.value,
                    dropdownBuilder: (context, selectedItem) {
                      return Text(selectedItem ?? "Please Select Company");
                    },
                    popupProps: PopupProps.menu(
                      showSearchBox: true,
                      showSelectedItems: true,
                      itemBuilder: (ctx, item, isDisabled, isSelected) {
                        return ListTile(
                          title: Text(item),
                        );
                      },
                      constraints: BoxConstraints(
                        maxHeight: (item.dropdownCategory.length > 5) ? 300.0 : 150.0,
                      ),
                    ),
                    onChanged: (value) {
                      item.selectCompany.value = value!;
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Obx((){
                    return AppButton(
                      title: "Add Item",
                      height: size.height * 0.05,
                      width: double.infinity,
                      loading: item.loading.loading.value,
                      onTap: (){
                        if(_key.currentState!.validate()){
                          item.addItemData();
                        }
                      },
                    );
                  }),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
