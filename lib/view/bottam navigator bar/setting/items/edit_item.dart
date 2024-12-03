import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/view%20model/firebase/item_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../../res/component/app_button.dart';
import '../../../../../../res/component/invoice_text_field.dart';

class EditItem extends StatefulWidget {
  EditItem({Key? key}) : super(key: key);

  @override
  State<EditItem> createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  final _key = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  final item = Get.put(ItemController());
  final itemId = Get.arguments;


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    TextEditingController updateBarcode = TextEditingController(text: itemId[1]);
    TextEditingController updateItemName = TextEditingController(text: itemId[2]);
    TextEditingController updateSale = TextEditingController(text: itemId[3]);
    TextEditingController updateCost = TextEditingController(text: itemId[4]);
    TextEditingController updateDiscount = TextEditingController(text: itemId[5]);
    TextEditingController updateTax = TextEditingController(text: itemId[6]);
    TextEditingController updateStartDate = TextEditingController(text: itemId[7]);
    TextEditingController updateEndDate = TextEditingController(text: itemId[8]);
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Item"),
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
                  GestureDetector(
                    onTap: item.scanQRCode,
                    child: InvoiceTextField(
                      title: "Barcode",
                      controller: updateBarcode,
                      enabled: false,
                      validator: (value){
                        return value!.isEmpty ? "Enter Your Item Name" : null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  InvoiceTextField(
                    title: "Item Name",
                    controller: updateItemName,
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
                          controller: updateSale,
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
                          controller: updateCost,
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
                          controller: updateDiscount,
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
                          controller: updateTax,
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
                    ),
                    onChanged: (value) {
                      item.selectCompany.value = value!;
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: InvoiceTextField(
                          title: "Start Date",
                          keyboardType: TextInputType.datetime,
                          readOnly: true,
                          controller: updateStartDate,
                          onTap: () => _dateNow(context),
                        ),
                      ),
                      SizedBox(width: size.width * 0.04,),
                      Flexible(
                        child: InvoiceTextField(
                          title: "Expiry Date",
                          keyboardType: TextInputType.datetime,
                          readOnly: true,
                          controller: updateEndDate,
                          onTap: () => _dateExpiry(context),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  AppButton(
                    title: "Edit Item",
                    height: size.height * 0.05,
                    width: double.infinity,
                    loading: item.loading.loading.value,
                    onTap: (){
                      if(_key.currentState!.validate()){
                        item.editItem(
                          itemId[0],
                          itemId[1],
                          itemId[2],
                          itemId[3],
                          itemId[4],
                          itemId[5],
                          itemId[6],
                          itemId[7],
                          itemId[8],
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
  Future<void> _dateNow(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDate),
      );
      if (pickedTime != null) {
        setState(() {
          selectedDate = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          // updateStartDate = DateFormat.yMd().add_jm().format(selectedDate);
        });
      }
    }
  }
  Future<void> _dateExpiry(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDate),
      );
      if (pickedTime != null) {
        setState(() {
          selectedDate = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          // updateEndDate = DateFormat.yMd().add_jm().format(selectedDate);
        });
      }
    }
  }
}
