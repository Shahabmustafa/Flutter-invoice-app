import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/view%20model/firebase/item_controller.dart';
import 'package:get/get.dart';

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
  final controller = Get.put(ItemController());
  final itemId = Get.arguments;


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                  Obx((){
                    return InvoiceTextField(
                      title: "Barcode",
                      controller: controller.barcode.value,
                    );
                  }),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  InvoiceTextField(
                    title: "Item Name",
                    controller: controller.itemName.value,
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
                          controller: controller.sale.value,
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
                          controller: controller.cost.value,
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
                          controller: controller.discount.value,
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
                          controller: controller.tax.value,
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
                  DropdownSearch<String>(
                    items: (f, cs) => controller.dropdownCategory,
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
                      controller.selectCategory.value = value!;
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  DropdownSearch<String>(
                    items: (es,i) => controller.dropdownCompany.value,
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
                      controller.selectCompany.value = value!;
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
                          controller: controller.saleDate.value,
                          onTap: () => _dateNow(context),
                        ),
                      ),
                      SizedBox(width: size.width * 0.04,),
                      Flexible(
                        child: InvoiceTextField(
                          title: "Expiry Date",
                          keyboardType: TextInputType.datetime,
                          readOnly: true,
                          controller: controller.expiryDate.value,
                          onTap: () => _dateExpiry(context),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Obx((){
                    return AppButton(
                      title: "Edit Item",
                      height: size.height * 0.05,
                      width: double.infinity,
                      loading: controller.loading.loading.value,
                      onTap: (){
                        if(_key.currentState!.validate()){
                          controller.editItem(itemId[0]);
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
