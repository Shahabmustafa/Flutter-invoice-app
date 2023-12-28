import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/view%20model/firebase/item_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../res/component/app_button.dart';
import '../../../../../res/component/invoice_text_field.dart';

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
        child: Form(
          key: _key,
          child: Column(
            children: [
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
                  Flexible(
                    child: InvoiceTextField(
                      title: "Cost",
                      controller: item.cost.value,
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: InvoiceTextField(
                      title: "Whole Sale",
                      controller: item.wholeSale.value,
                      keyboardType: TextInputType.number,
                      validator: (value){
                        return value!.isEmpty ? "Enter Your Item Price" : null;
                      },
                    ),
                  ),
                  Flexible(
                    child: InvoiceTextField(
                      title: "Tax",
                      controller: item.tax.value,
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
                title: "Company Name",
                controller: item.companyName.value,
                validator: (value){
                  return value!.isEmpty ? "Enter Your Item Name" : null;
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
                      controller: item.saleDate.value,
                      onTap: () => _dateNow(context),
                    ),
                  ),
                  Flexible(
                    child: InvoiceTextField(
                      title: "Expiry Date",
                      keyboardType: TextInputType.datetime,
                      readOnly: true,
                      controller: item.expiryDate.value,
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
                  title: "Add Item",
                  height: size.height * 0.05,
                  width: size.width * 0.94,
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
          item.saleDate.value.text = DateFormat.yMd().add_jm().format(selectedDate);
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
          item.expiryDate.value.text = DateFormat.yMd().add_jm().format(selectedDate);
        });
      }
    }
  }
}
