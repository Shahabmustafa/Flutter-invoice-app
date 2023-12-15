import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                validator: (value){
                  return value!.isEmpty ? "Enter Your Item Whole Price" : null;
                },
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              InvoiceTextField(
                title: "Tax",
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
                // controller: itemService.description.value,
                enabled: false,
                // validator: (value){
                //   return value!.isEmpty ? "Enter Your Item Description" : null;
                // },
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              InvoiceTextField(
                title: "Paid",
                keyboardType: TextInputType.number,
                controller: itemService.paid.value,
                enabled: true,
                validator: (value){
                  return value!.isEmpty ? "Enter Your Item Description" : null;
                },
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              InvoiceTextField(
                title: "Total Dept",
                keyboardType: TextInputType.number,
                // controller: itemService.paid.value,
                enabled: false,
                // validator: (value){
                //   return value!.isEmpty ? "Enter Your Item Description" : null;
                // },
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
