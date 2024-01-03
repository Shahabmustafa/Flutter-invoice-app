import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/app_api/app_api_service.dart';
import 'package:flutter_invoice_app/res/calculation/calculation.dart';
import 'package:flutter_invoice_app/res/colors/app_colors.dart';
import 'package:flutter_invoice_app/res/component/app_button.dart';
import 'package:flutter_invoice_app/view%20model/firebase/item_controller.dart';
import 'package:flutter_invoice_app/view%20model/firebase/sale_controller.dart';
import 'package:get/get.dart';

import '../../../view model/firebase/order_controller.dart';

class SalesPage extends StatefulWidget {
  const SalesPage({Key? key}) : super(key: key);

  @override
  State<SalesPage> createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {

  String? itemName;
  List<String> itemDropdown = [];
  String? customerName;
  List<String> customerDropdown = [];
  final sale = Get.put(SaleController());

  final quantity = TextEditingController();
  final itemSale = TextEditingController();

  Future<void> itemNameSetState() async {
    List<String> data = await sale.itemsName();
    setState(() {
      itemDropdown = data;
    });
  }
  Future<void> customerNameSetState() async {
    List<String> data = await sale.customerName();
    setState(() {
      customerDropdown = data;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    itemNameSetState();
    customerNameSetState();
  }
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Sale"),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                      items: itemDropdown.map((String value) {
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
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              child: Container(
                padding: EdgeInsets.all(10),
                height: size.height * 0.6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade300,
                ),
                child: StreamBuilder(
                  stream: AppApiService.item.doc("${itemName}").snapshots(),
                  builder: (context,snapshot){
                    if(snapshot.hasData){
                      Map<String,dynamic> data = snapshot.data!.data() as Map<String,dynamic>;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              height: size.height * 0.3,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Whole Sale",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500
                                        ),
                                      ),
                                      Text(
                                        data["wholeSale"],
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Sale",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500
                                        ),
                                      ),
                                      Container(
                                        height: 40,
                                        width: 70,
                                        padding: EdgeInsets.only(left: 15),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: AppColor.primaryColor,
                                          ),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                          child: TextFormField(
                                            controller: itemSale,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Quantity",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500
                                        ),
                                      ),
                                      Container(
                                        height: 40,
                                        width: 70,
                                        padding: EdgeInsets.only(left: 15),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: AppColor.primaryColor,
                                          ),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                          child: TextFormField(
                                            controller: quantity,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Total",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500
                                        ),
                                      ),
                                      Text(
                                        data["wholeSale"],
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Receive Amount",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500
                                        ),
                                      ),
                                      Container(
                                        height: 40,
                                        width: 70,
                                        padding: EdgeInsets.only(left: 15),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: AppColor.primaryColor,
                                          ),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                          child: TextFormField(
                                            controller: quantity,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Due Amount",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500
                                        ),
                                      ),
                                      Text(
                                        data["wholeSale"],
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: FormField<String>(
                              builder: (FormFieldState<String> state) {
                                return InputDecorator(
                                  decoration: InputDecoration(
                                    labelText: 'Customer Name',
                                    errorText: state.errorText,
                                    border: InputBorder.none,
                                  ),
                                  isEmpty: customerName == null || customerName!.isEmpty,
                                  child: DropdownButtonFormField<String>(
                                    value: customerName,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    items: customerDropdown.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        customerName = value;
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
                          AppButton(
                            title: "Sale",
                            height: size.height * 0.06,
                            width: size.width * 1,
                            onTap: (){

                            },
                          ),
                        ],
                      );
                    }else{
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}