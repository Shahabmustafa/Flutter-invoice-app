import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/colors/app_colors.dart';

import '../../../res/component/app_button.dart';
import '../../../res/component/invoice_text_field.dart';

class ItemList extends StatefulWidget {
  const ItemList({Key? key}) : super(key: key);

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("List of Item"),
      ),
      body: Column(
        children: [

        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showModalBottomSheet(
            context: context,
            builder: (context){
              return Form(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Text(
                      "Add new Item",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppColor.primaryColor,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    InvoiceTextField(
                      title: "Item Name",
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    InvoiceTextField(
                      title: "Item Cost",
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    InvoiceTextField(
                      title: "Quality",
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    AppButton(
                      title: "Add Item",
                      height: size.height * 0.05,
                      width: size.width * 0.4,
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
