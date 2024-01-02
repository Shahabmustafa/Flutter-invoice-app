import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/app_api/app_api_service.dart';
import 'package:flutter_invoice_app/res/colors/app_colors.dart';
import 'package:flutter_invoice_app/view%20model/firebase/item_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../../res/component/app_button.dart';
import '../../../../../../res/component/invoice_text_field.dart';

class EditItem extends StatefulWidget {
  const EditItem({Key? key}) : super(key: key);

  @override
  State<EditItem> createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  final _key = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  final item = Get.put(ItemController());

  final itemId = Get.arguments;

  String? companyName;
  List<String> dropdownItems = [];

  String? Categori;
  List<String> dropdownItemCategori = [];


  Future<void> categoriFetchDataAndSetState() async {
    List<String> data = await item.fetchDropdownDataFromFirebase();
    setState(() {
      dropdownItems = data;
    });
  }

  Future<void> fetchDataAndSetState() async {
    List<String> data = await item.categoriGetDataDropDown();
    setState(() {
      dropdownItemCategori = data;
    });
  }

  TextEditingController categori = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchDataAndSetState();
    categoriFetchDataAndSetState();
  }
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Item"),
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
                controller: item.stock.value,
                keyboardType: TextInputType.number,
                validator: (value){
                  return value!.isEmpty ? "Enter Your Item Name" : null;
                },
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FormField<String>(
                  builder: (FormFieldState<String> state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Categori Name',
                        errorText: state.errorText,
                        border: InputBorder.none,
                      ),
                      isEmpty: Categori == null || Categori!.isEmpty,
                      child: DropdownButtonFormField<String>(
                        value: Categori,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        items: dropdownItemCategori.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            Categori = value;
                          });
                          state.didChange(value);
                        },
                      ),
                    );
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select an option';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FormField<String>(
                  builder: (FormFieldState<String> state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Company Name',
                        errorText: state.errorText,
                        border: InputBorder.none,
                      ),
                      isEmpty: companyName == null || companyName!.isEmpty,
                      child: DropdownButtonFormField<String>(
                        value: companyName,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        items: dropdownItems.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            companyName = value;
                          });
                          state.didChange(value);
                        },
                      ),
                    );
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select an option';
                    }
                    return null;
                  },
                ),
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
                  title: "Update Item",
                  height: size.height * 0.05,
                  width: size.width * 0.94,
                  loading: item.loading.loading.value,
                  onTap: (){
                    if(_key.currentState!.validate()){
                      item.editItem(companyName.toString(), itemId, Categori.toString());
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
