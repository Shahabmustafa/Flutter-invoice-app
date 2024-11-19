import 'package:badges/badges.dart' as badges;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_invoice_app/res/colors/app_colors.dart';
import 'package:flutter_invoice_app/res/component/app_button.dart';
import 'package:flutter_invoice_app/view/bottam%20navigator%20bar/sales/add_to_card.dart';

class SalesPage extends StatefulWidget {
  const SalesPage({Key? key}) : super(key: key);

  @override
  State<SalesPage> createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  List<Product> addProduct = [];
  int cartCount = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Sale Invoice"),
        automaticallyImplyLeading: false,
        actions: [
          badges.Badge(
            position: badges.BadgePosition.topEnd(top: 0, end: 3),
            badgeContent: Text(
              cartCount.toString(),
              style: TextStyle(color: Colors.white, fontSize: 10),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddToCardScreen(product: addProduct)),
                );
              },
              icon: Icon(
                CupertinoIcons.shopping_cart,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Text("${index + 1}"),
              title: Text(products[index].product),
              subtitle: Text("Stock " + products[index].stock.toString()),
              trailing: AppButton(
                title: "Add",
                height: 30,
                width: 100,
                onTap: () {
                  if (products[index].stock > 0) {
                    Product product = Product(
                      product: products[index].product,
                      price: products[index].price,
                      stock: products[index].stock,
                    );

                    setState(() {
                      // Check if the product already exists in the cart
                      int existingIndex = addProduct.indexWhere((p) => p.product == product.product);
                      if (existingIndex == -1) {
                        // Add new product to cart
                        addProduct.add(product);
                      } else {
                        // Increment quantity if product already exists in the cart
                        addProduct[existingIndex].stock += 1;
                      }
                      cartCount = addProduct.length;

                      // Decrease stock of the product
                      products[index].stock -= 1;
                    });
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class Product {
  String product;
  double price;
  int stock;

  Product({
    required this.product,
    required this.price,
    required this.stock,
  });

  @override
  String toString() {
    return 'Product(product: $product, price: $price, stock: $stock)';
  }
}

List<Product> products = [
  Product(product: "Laptop", price: 1000.0, stock: 5),
  Product(product: "Smartphone", price: 700.0, stock: 10),
  Product(product: "Headphones", price: 150.0, stock: 15),
  Product(product: "Keyboard", price: 50.0, stock: 20),
  Product(product: "Mouse", price: 25.0, stock: 30),
  Product(product: "Monitor", price: 300.0, stock: 8),
  Product(product: "Printer", price: 200.0, stock: 12),
  Product(product: "Tablet", price: 500.0, stock: 7),
  Product(product: "Smartwatch", price: 250.0, stock: 14),
  Product(product: "Charger", price: 20.0, stock: 25),
];
