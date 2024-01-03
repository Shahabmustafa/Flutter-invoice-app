class SaleModel {
  String? itemName;
  String? sale;
  String? quantity;
  String? total;
  String? customerName;
  String? duePayment;
  String? receivePayment;

  SaleModel(
      {this.itemName,
        this.sale,
        this.quantity,
        this.total,
        this.customerName,
        this.duePayment,
        this.receivePayment});

  SaleModel.fromJson(Map<String, dynamic> json) {
    itemName = json['itemName'];
    sale = json['sale'];
    quantity = json['quantity'];
    total = json['total'];
    customerName = json['customerName'];
    duePayment = json['duePayment'];
    receivePayment = json['receivePayment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemName'] = this.itemName;
    data['sale'] = this.sale;
    data['quantity'] = this.quantity;
    data['total'] = this.total;
    data['customerName'] = this.customerName;
    data['duePayment'] = this.duePayment;
    data['receivePayment'] = this.receivePayment;
    return data;
  }
}