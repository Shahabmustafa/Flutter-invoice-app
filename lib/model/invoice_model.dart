class InvoiceItem {
  String productName;
  double unitPrice;
  int quantity;
  double discount;

  InvoiceItem({
    required this.productName,
    required this.unitPrice,
    required this.quantity,
    required this.discount,
  });

  double get total => (unitPrice * quantity) - discount;
}

class Invoice {
  List<InvoiceItem> items = [];
  DateTime date = DateTime.now();

  double get subtotal => items.fold(0, (sum, item) => sum + item.total);
  double get tax => subtotal * 0.15; // For example, 15% tax
  double get totalAmount => subtotal + tax;
}
