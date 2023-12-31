import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/view%20model/firebase/order_controller.dart';
import 'package:get/get.dart';
import '../../../../res/component/app_button.dart';
import '../../../../res/component/invoice_text_field.dart';

class AddOrder extends StatefulWidget {
  const AddOrder({Key? key}) : super(key: key);

  @override
  State<AddOrder> createState() => _AddOrderState();
}

class _AddOrderState extends State<AddOrder> {

  final _key = GlobalKey<FormState>();

  String? itemName;
  String? companyName;
  String? orderType;
  List<String> orderTypeDropDownItems = [
    "Sender",
    "Receiver",
  ];
  List<String> itemNameDropdownItems = [];
  List<String> companyNameDropdownItems = [];



  final orderController = Get.put(OrderController());

  Future<void> itemNameSetState() async {
    List<String> data = await orderController.itemsName();
    setState(() {
      itemNameDropdownItems = data;
    });
  }
  Future<void> companyNameSetState() async {
    List<String> data = await orderController.companysName();
    setState(() {
      companyNameDropdownItems = data;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    itemNameSetState();
    companyNameSetState();
  }
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Order"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FormField<String>(
                  builder: (FormFieldState<String> state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Item Name',
                        errorText: state.errorText,
                        border: InputBorder.none,
                      ),
                      isEmpty: itemName == null || itemName!.isEmpty,
                      child: DropdownButtonFormField<String>(
                        value: itemName,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        items: itemNameDropdownItems.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            itemName = value;
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
                        items: companyNameDropdownItems.map((String value) {
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
                     title: "Sale",
                     keyboardType: TextInputType.emailAddress,
                     controller: orderController.sale.value,
                     validator: (value){
                       return value!.isEmpty ? "Enter Your Email Address" : null;
                     },
                   ),
                 ),
                 Flexible(
                   child: InvoiceTextField(
                     title: "Cost",
                     controller: orderController.cost.value,
                     keyboardType: TextInputType.phone,
                     validator: (value){
                       return value!.isEmpty ? "Enter Your Phone Number" : null;
                     },
                   ),
                 ),
               ],
             ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Row(
                children: [
                  Flexible(
                    child: InvoiceTextField(
                      title: "Whole Sale",
                      controller: orderController.wholeSale.value,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value){
                        return value!.isEmpty ? "Enter Your Email Address" : null;
                      },
                    ),
                  ),
                  Flexible(
                    child: InvoiceTextField(
                      title: "Discount",
                      controller: orderController.discount.value,
                      keyboardType: TextInputType.phone,
                      validator: (value){
                        return value!.isEmpty ? "Enter Your Phone Number" : null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Row(
                children: [
                  Flexible(
                    child: InvoiceTextField(
                      title: "Tax",
                      controller: orderController.Tax.value,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value){
                        return value!.isEmpty ? "Enter Your Email Address" : null;
                      },
                    ),
                  ),
                  Flexible(
                    child: InvoiceTextField(
                      title: "Stock",
                      controller: orderController.Stock.value,
                      keyboardType: TextInputType.phone,
                      validator: (value){
                        return value!.isEmpty ? "Enter Your Phone Number" : null;
                      },
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
                        labelText: 'Type',
                        errorText: state.errorText,
                        border: InputBorder.none,
                      ),
                      isEmpty: orderType == null || orderType!.isEmpty,
                      child: DropdownButtonFormField<String>(
                        value: orderType,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        items: orderTypeDropDownItems.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            orderType = value;
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
              Obx((){
                return AppButton(
                  title: "Add Order",
                  height: size.height * 0.05,
                  width: size.width * 0.94,
                  loading: orderController.loading.loading.value,
                  onTap: (){
                    if(_key.currentState!.validate()){
                      orderController.addOrder(
                        itemName.toString(),
                        companyName.toString(),
                        orderType.toString(),
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
}
