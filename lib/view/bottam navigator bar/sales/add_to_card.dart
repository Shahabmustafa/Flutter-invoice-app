import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/view/bottam%20navigator%20bar/sales/sales_screen.dart';

class AddToCardScreen extends StatefulWidget {
  AddToCardScreen({required this.product,super.key});
  List<Product> product;
  @override
  State<AddToCardScreen> createState() => _AddToCardScreenState();
}

class _AddToCardScreenState extends State<AddToCardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add to Card"),
      ),
      body: ListView.builder(
        itemCount: widget.product.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Text("${index + 1}"),
              title: Text(widget.product[index].product),
              subtitle: Text("Stock " + widget.product[index].stock.toString()),
              trailing: IconButton(
                onPressed: () {
                  Product product = Product(
                    product: products[index].product,
                    price: products[index].price,
                    stock: products[index].stock,
                  );
                  setState(() {
                    widget.product.add(product);
                  });
                },
                icon: Icon(CupertinoIcons.add_circled),
              ),
            ),
          );
        },
      ),
    );
  }
}
