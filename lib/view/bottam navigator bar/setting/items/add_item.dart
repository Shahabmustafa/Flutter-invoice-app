import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/app_api/app_api_service.dart';
import 'package:flutter_invoice_app/res/colors/app_colors.dart';
import 'package:flutter_invoice_app/res/component/drop_down_textfield.dart';
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


  String? selectedDropdownValue;
  List<String> dropdownItems = [];

  String? selectedDropdownValueCategori;
  List<String> dropdownItemCategori = [];

  Future<List<String>> fetchDropdownDataFromFirebase() async {
    List<String> dropdownItems = [];
    try {
      QuerySnapshot querySnapshot = await AppApiService.supplier.get();
      if (querySnapshot.docs.isNotEmpty) {
        dropdownItems = querySnapshot.docs.map((doc) => doc['companyName'].toString()).toList();
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
    return dropdownItems;
  }
  Future<List<String>> categoriGetDataDropDown() async {
    List<String> dropdownItems = [];
    try {
      QuerySnapshot querySnapshot = await AppApiService.categori.get();
      if (querySnapshot.docs.isNotEmpty) {
        dropdownItems = querySnapshot.docs.map((doc) => doc['categori'].toString()).toList();
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
    return dropdownItems;
  }

  Future<void> categoriFetchDataAndSetState() async {
    List<String> data = await fetchDropdownDataFromFirebase();
    setState(() {
      dropdownItems = data;
    });
  }

  Future<void> fetchDataAndSetState() async {
    List<String> data = await categoriGetDataDropDown();
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
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return InputDecorator(
                            decoration: InputDecoration(
                              labelText: 'Categori Name',
                              errorText: state.errorText,
                              border: InputBorder.none,
                            ),
                            isEmpty: selectedDropdownValueCategori == null || selectedDropdownValueCategori!.isEmpty,
                            child: DropdownButtonFormField<String>(
                              value: selectedDropdownValueCategori,
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
                                  selectedDropdownValueCategori = value;
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
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10,top: 15),
                    child: GestureDetector(
                      onTap: (){
                        Get.defaultDialog(
                          title: "Add Categori",
                          content: InvoiceTextField(
                            title: "Categori",
                            controller: categori,
                            validator: (value){
                              return value!.isEmpty ? "Please Fill this Field" : null;
                            },
                          ),
                          confirm: AppButton(
                            title: "Add",
                            color: Colors.green,
                            height: size.height * 0.04,
                            width: size.width * 0.2,
                            onTap: (){
                              AppApiService.categori.add({
                                "categori" : categori.text,
                              }).then((value){
                                categori.clear();
                                Get.back();
                              });
                            },
                          ),
                          cancel: AppButton(
                            title: "Cancel",
                            color: AppColor.errorColor,
                            height: size.height * 0.04,
                            width: size.width * 0.2,
                            onTap: (){
                              Get.back();
                            },
                          ),
                        );
                      },
                      child: Icon(Icons.add),
                    ),
                  ),
                ],
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
                      isEmpty: selectedDropdownValue == null || selectedDropdownValue!.isEmpty,
                      child: DropdownButtonFormField<String>(
                        value: selectedDropdownValue,
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
                            selectedDropdownValue = value;
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
                  title: "Add Item",
                  height: size.height * 0.05,
                  width: size.width * 0.94,
                  loading: item.loading.loading.value,
                  onTap: (){
                    if(_key.currentState!.validate()){
                      item.addItemData(
                        selectedDropdownValue.toString(),
                      );
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
