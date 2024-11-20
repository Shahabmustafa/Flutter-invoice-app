class Product {
  String product;
  double price;
  int stock;
  double discount;
  double tax;

  Product({
    required this.product,
    required this.price,
    required this.stock,
    required this.tax,
    required this.discount,
  });

  // Convert Product to Map
  Map<String, dynamic> toMap() {
    return {
      'product': product,
      'price': price,
      'stock': stock,
      'discount': discount,
      'tax': tax,
    };
  }

  // Create Product from Map
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      product: map['product'],
      price: (map['price'] as num).toDouble(),
      stock: map['stock'],
      discount: (map['discount'] as num).toDouble(),
      tax: (map['tax'] as num).toDouble(),
    );
  }

  @override
  String toString() {
    return 'Product(product: $product, price: $price, stock: $stock, discount: $discount, tax: $tax)';
  }
}
