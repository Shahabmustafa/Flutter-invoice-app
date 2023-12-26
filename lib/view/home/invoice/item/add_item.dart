import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../res/component/app_button.dart';
import '../../../../res/component/invoice_text_field.dart';
import '../../../../view model/invoice service/Item_service.dart';

class AddItem extends StatefulWidget {
  const AddItem({Key? key}) : super(key: key);

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final _key = GlobalKey<FormState>();
  final itemService = Get.put(ItemService());

  DateTime selectedDate = DateTime.now();

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
          itemService.startDate.value.text = DateFormat.yMd().add_jm().format(selectedDate);
        });
      }
    }
  }
  Future<void> _dateDue(BuildContext context) async {
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
          itemService.dueDate.value.text = DateFormat.yMd().add_jm().format(selectedDate);
        });
      }
    }
  }


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
                height: size.height * 0.05,
              ),
              InvoiceTextField(
                title: "Customer Name",
                controller: itemService.customerName.value,
                validator: (value){
                  return value!.isEmpty ? "Enter Your Customer Name" : null;
                },
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              InvoiceTextField(
                title: "Email Address",
                controller: itemService.customerEmail.value,
                keyboardType: TextInputType.emailAddress,
                validator: (value){
                  return value!.isEmpty ? "Enter Your Email Address" : null;
                },
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              InvoiceTextField(
                controller: itemService.customerPhone.value,
                title: "Phone Number",
                keyboardType: TextInputType.phone,
                validator: (value){
                  return value!.isEmpty ? "Enter Your Phone Number" : null;
                },
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              InvoiceTextField(
                title: "Address",
                controller: itemService.customerAddress.value,
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                validator: (value){
                  return value!.isEmpty ? "Enter Your Address" : null;
                },
              ),
              SizedBox(
                height: size.height * 0.02,
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
              InvoiceTextField(
                title: "Discount",
                controller: itemService.discount.value,
                maxLength: 2,
                suffix: Text("%"),
                validator: (value){
                  return value!.isEmpty ? "Enter Your Item Whole Price" : null;
                },
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              InvoiceTextField(
                title: "Tax",
                suffix: Text("%"),
                maxLength: 2,
                keyboardType: TextInputType.number,
                controller: itemService.tax.value,
                validator: (value){
                  return value!.isEmpty ? "Enter Your Item Tax" : null;
                },
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              InvoiceTextField(
                title: "Total",
                keyboardType: TextInputType.number,
                enabled: false,
                onChanged: (value){
                },
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              InvoiceTextField(
                title: "Paid",
                keyboardType: TextInputType.number,
                controller: itemService.paid.value,
                validator: (value){
                  return value!.isEmpty ? "Enter Your Total Paid" : null;
                },
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              InvoiceTextField(
                title: "Total Dept",
                keyboardType: TextInputType.number,
                // controller: itemService.paid.value,
                // enabled: false,
                readOnly: true,
                // validator: (value){
                //   return value!.isEmpty ? "Enter Your Item Description" : null;
                // },
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Row(
                children: [
                  Flexible(
                    child: InvoiceTextField(
                      title: "Start Date",
                      controller: itemService.startDate.value,
                      keyboardType: TextInputType.datetime,
                      readOnly: true,
                      onTap: () => _dateNow(context),
                    ),
                  ),
                  Flexible(
                    child: InvoiceTextField(
                      title: "Due Date",
                      controller: itemService.dueDate.value,
                      keyboardType: TextInputType.datetime,
                      readOnly: true,
                      onTap: () => _dateDue(context),
                    ),
                  ),
                ],
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
