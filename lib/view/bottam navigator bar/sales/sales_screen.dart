import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/app_api/app_api_service.dart';
import 'package:flutter_invoice_app/res/colors/app_colors.dart';
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
  final sale = Get.put(SaleController());

  Future<void> itemNameSetState() async {
    List<String> data = await sale.itemsName();
    setState(() {
      itemDropdown = data;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    itemNameSetState();
  }
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Sale"),
        automaticallyImplyLeading: false,
      ),
      body: Column(
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
          Container(
            height: size.height * 0.25,
            child: StreamBuilder(
              stream: AppApiService.item.doc("${itemName}").snapshots(),
              builder: (context,snapshot){
                if(snapshot.hasData){
                  Map<String,dynamic> data = snapshot.data!.data() as Map<String,dynamic>;
                  return Container(
                    height: size.height * 0.2,
                    width: size.width,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Sale",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.02,
                            ),
                            Text(
                              data["sale"],
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Sale",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.02,
                            ),
                            Text(
                              data["sale"],
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }else{
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
