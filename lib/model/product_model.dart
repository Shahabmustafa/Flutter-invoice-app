class Product {
  String productId;
  String product;
  double purchasePrice;
  double salePrice;
  int stock;
  double discount;
  double tax;

  Product({
    required this.productId,
    required this.product,
    required this.purchasePrice,
    required this.salePrice,
    required this.stock,
    required this.tax,
    required this.discount,
  });

  // Convert Product to Map
  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'product': product,
      'purchasePrice': purchasePrice,
      'salePrice': salePrice,
      'stock': stock,
      'discount': discount,
      'tax': tax,
    };
  }

  // Create Product from Map
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      productId: map['productId'],
      product: map['product'],
      purchasePrice: (map['purchasePrice'] as num).toDouble(),
      salePrice: (map['salePrice'] as num).toDouble(),
      stock: map['stock'],
      discount: (map['discount'] as num).toDouble(),
      tax: (map['tax'] as num).toDouble(),
    );
  }

  @override
  String toString() {
    return 'Product(productId: $productId,product: $product, purchasePrice: $purchasePrice,salePrice: $salePrice,stock: $stock, discount: $discount, tax: $tax)';
  }
}
